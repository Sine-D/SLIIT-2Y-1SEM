package com.video.servlet;

import com.video.model.Contact;
import com.video.service.ContactService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/officer/*")
public class CustomerServiceOfficerServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CustomerServiceOfficerServlet.class.getName());
    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
        LOGGER.info("CustomerServiceOfficerServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // Handle logout
        if (request.getParameter("logout") != null && request.getParameter("logout").equals("true")) {
            if (session != null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/loginCus.jsp");
                return;
            }
        }
        // Check if user is logged in
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect(request.getContextPath() + "/loginCus.jsp");
            return;
        }

        String pathInfo = request.getPathInfo() != null ? request.getPathInfo() : "/";
        try {
            switch (pathInfo) {
                case "/":
                    // List all contacts
                    List<Contact> contacts = contactService.getAllContacts();
                    request.setAttribute("contacts", contacts);
                    request.getRequestDispatcher("/dashboardCus.jsp").forward(request, response);
                    break;
                case "/edit":
                    // Get contact for editing
                    int id = Integer.parseInt(request.getParameter("id"));
                    Contact contact = contactService.getContactById(id);
                    if (contact != null) {
                        request.setAttribute("contact", contact);
                        request.getRequestDispatcher("/dashboardCus.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Contact not found");
                    }
                    break;
                case "/delete":
                    // Delete contact
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    contactService.deleteContact(deleteId);
                    response.sendRedirect(request.getContextPath() + "/officer");
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid id parameter: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("login".equals(action)) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                if (contactService.authenticateOfficer(username, password)) {
                    session.setAttribute("loggedIn", true);
                    session.setAttribute("username", username);
                    response.sendRedirect(request.getContextPath() + "/officer");
                } else {
                    request.setAttribute("error", "Invalid username or password");
                    request.getRequestDispatcher("/loginCus.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                LOGGER.severe("SQLException during login: " + e.getMessage());
                throw new ServletException("Database error", e);
            }
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                String handledBy = request.getParameter("handledBy");
                String internalNotes = request.getParameter("internalNotes");

                Contact contact = new Contact();
                contact.setMessageId(id);
                contact.setStatus(status);
                contact.setHandledBy(handledBy);
                contact.setInternalNotes(internalNotes);

                contactService.updateContact(contact);
                response.sendRedirect(request.getContextPath() + "/officer");
            } catch (SQLException e) {
                LOGGER.severe("SQLException during update: " + e.getMessage());
                throw new ServletException("Error updating contact", e);
            } catch (NumberFormatException e) {
                LOGGER.severe("Invalid id parameter: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            LOGGER.warning("Unknown action: " + action);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
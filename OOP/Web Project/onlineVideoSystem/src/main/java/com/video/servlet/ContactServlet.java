package com.video.servlet;

import com.video.model.Contact;
import com.video.service.ContactService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ContactServlet.class.getName());
    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to contact form JSP
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Create Contact object
        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setSubject(subject);
        contact.setMessage(message);

        try {
            // Save contact to database
            contactService.addContact(contact);
            // Redirect to success page
            response.sendRedirect(request.getContextPath() + "/submission-successful.jsp");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Error saving contact: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while sending your message. Please try again later.");
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
        }
    }
}
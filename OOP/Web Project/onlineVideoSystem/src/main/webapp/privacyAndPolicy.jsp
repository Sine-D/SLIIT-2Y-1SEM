<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vidoora - Privacy Policy</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #f3f3f3;
        }

        .vidoora-red {
            color: #ff1a1a;
        }

        .vidoora-bg-red {
            background-color: #ff1a1a;
        }

        .vidoora-border-red {
            border-color: #ff1a1a;
        }

        header {
            background: #0d0d0d;
            color: white;
            padding: 6px 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            height: 60px;
        }

        .logo {
            font-size: 24px;
            color: #00aaff;
            font-weight: bold;
            padding: 6px;
        }

        nav {
            display: flex;
            align-items: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        nav a {
            color: #ccc;
            margin: 0 15px;
            text-decoration: none;
            font-size: 16px;
        }

        nav a:hover {
            color: #fff;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            color: #ccc;
            background: none;
            border: none;
            font-size: 15px;
            cursor: pointer;
            padding: 0;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background: #333;
            min-width: 150px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: #ccc;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background: #444;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .icons a {
            color: #ccc;
            margin-left: 15px;
            text-decoration: none;
            font-size: 18px;
        }

        .profile {
            background: #ff4444;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
    </style>
</head>

<body class="min-h-screen flex flex-col">
<jsp:include page="header.jsp" />

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8 flex-grow">
        <div class="max-w-4xl mx-auto bg-gray-900 rounded-lg shadow-xl p-6 md:p-8">
            <div class="border-b border-gray-700 pb-4 mb-6">
                <h1 class="text-3xl font-bold vidoora-red">Privacy Policy</h1>
                <p class="text-gray-400 mt-2">Last Updated: May 13, 2025</p>
            </div>

            <div class="space-y-8">
                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">1. Introduction</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        Welcome to Vidoora. We are committed to protecting your privacy and ensuring you have a positive
                        experience when using our online video streaming platform. This Privacy Policy explains how we
                        collect, use, disclose, and safeguard your information when you visit our website and use our
                        services.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">2. Information We Collect</h2>
                    <div class="pl-4 space-y-4">
                        <div>
                            <h3 class="font-medium text-white">2.1 Personal Information</h3>
                            <p class="text-gray-300 leading-relaxed mt-2" style="text-align: justify;">
                                We may collect personal information that you voluntarily provide to us when you register
                                on our platform, express interest in obtaining information about us or our products, or
                                otherwise contact us. This personal information may include:
                            </p>
                            <ul class="list-disc pl-6 mt-2 text-gray-300">
                                <li>Name and contact details</li>
                                <li>Email address</li>
                                <li>Username and password</li>
                                <li>Billing information and payment details</li>
                                <li>Profile information</li>
                            </ul>
                        </div>

                        <div>
                            <h3 class="font-medium text-white">2.2 Usage Information</h3>
                            <p class="text-gray-300 leading-relaxed mt-2" style="text-align: justify;">
                                We automatically collect certain information when you visit, use, or navigate our
                                platform. This information does not reveal your specific identity but may include:
                            </p>
                            <ul class="list-disc pl-6 mt-2 text-gray-300">
                                <li>Device and usage information</li>
                                <li>IP address</li>
                                <li>Browser and device characteristics</li>
                                <li>Operating system</li>
                                <li>Viewing history and preferences</li>
                                <li>Referring URLs</li>
                            </ul>
                        </div>
                    </div>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">3. How We Use Your Information</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        We use the information we collect for various purposes, including:
                    </p>
                    <ul class="list-disc pl-6 mt-2 text-gray-300">
                        <li>Providing, operating, and maintaining our services</li>
                        <li>Improving and personalizing your experience</li>
                        <li>Understanding how you use our platform</li>
                        <li>Developing new features and services</li>
                        <li>Communicating with you about updates, security alerts, and support</li>
                        <li>Providing customer support</li>
                        <li>Processing payments and preventing fraud</li>
                        <li>Complying with legal obligations</li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">4. Cookies and Tracking Technologies</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        We may use cookies, web beacons, and similar tracking technologies to collect information about
                        your browsing activities and to improve your experience on our platform. These technologies help
                        us understand how you use our service, which content you prefer, and how to optimize our
                        offerings.
                    </p>
                    <p class="text-gray-300 leading-relaxed mt-2" style="text-align: justify;">
                        You can control cookies through your browser settings and other tools. However, disabling
                        cookies may limit your ability to use certain features of our service.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">5. How We Share Your Information</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        We may share your information in the following situations:
                    </p>
                    <ul class="list-disc pl-6 mt-2 text-gray-300">
                        <li style="text-align: justify;"><span class="font-medium">With Service Providers:</span> We may share your information with
                            service providers who perform services for us, such as payment processing, data analysis,
                            email delivery, hosting services, and customer service.</li>
                        <li style="text-align: justify;"><span class="font-medium">Business Transfers:</span> We may share or transfer your
                            information in connection with, or during negotiations of, any merger, sale of company
                            assets, financing, or acquisition of all or a portion of our business to another company.
                        </li>
                        <li style="text-align: justify;"><span class="font-medium">With Your Consent:</span> We may disclose your information for any
                            other purpose with your consent.</li>
                        <li style="text-align: justify;"><span class="font-medium">Legal Requirements:</span> We may disclose your information where
                            we are legally required to do so to comply with applicable law, governmental requests,
                            judicial proceedings, court orders, or legal processes.</li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">6. Data Security</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        We implement appropriate technical and organizational security measures designed to protect the
                        security of any personal information we process. However, despite our safeguards, no security
                        system is impenetrable. We cannot guarantee the security of our databases, nor can we guarantee
                        that information you provide won't be intercepted while being transmitted to us over the
                        Internet.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">7. Your Privacy Rights</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        Depending on your location, you may have certain rights regarding your personal information,
                        such as:
                    </p>
                    <ul class="list-disc pl-6 mt-2 text-gray-300">
                        <li>The right to access the personal information we have about you</li>
                        <li>The right to request correction of inaccurate information</li>
                        <li>The right to request deletion of your personal information</li>
                        <li>The right to object to processing of your personal information</li>
                        <li>The right to data portability</li>
                        <li>The right to withdraw consent</li>
                    </ul>
                    <p class="text-gray-300 leading-relaxed mt-2" style="text-align: justify;">
                        To exercise these rights, please contact us using the information provided in the "Contact Us"
                        section.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">8. Children's Privacy</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        Our services are not directed to individuals under the age of 13 (or the applicable age in your
                        jurisdiction). We do not knowingly collect personal information from children. If we become
                        aware that a child has provided us with personal information, we will take steps to delete such
                        information. If you become aware that a child has provided us with personal information, please
                        contact us.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">9. Changes to This Privacy Policy</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        We may update this Privacy Policy from time to time to reflect changes to our practices or for
                        other operational, legal, or regulatory reasons. The updated version will be indicated by an
                        updated "Last Updated" date. We encourage you to review this Privacy Policy frequently to stay
                        informed about how we are protecting your information.
                    </p>
                </section>

                <section>
                    <h2 class="text-xl font-semibold vidoora-red mb-3">10. Contact Us</h2>
                    <p class="text-gray-300 leading-relaxed" style="text-align: justify;">
                        If you have questions or concerns about this Privacy Policy or our practices, please contact us
                        at:
                    </p>
                    <p class="text-gray-300 leading-relaxed mt-2">
                       <center><a href="#"> <button   class="relative overflow-hidden rounded-lg bg-black px-6 py-2 font-medium text-white transition-all duration-300">
                            <span class="relative z-10">Contact</span>
                            <span class="absolute bottom-0 left-0 h-1 w-full bg-red-600 transition-all duration-300 hover:h-full"></span>
                        </button></a></center>
                </section>
            </div>

            <div class="mt-8 pt-6 border-t border-gray-700">
        
            </div>
        </div>
    </main>

<jsp:include page="footer.jsp" />
</body>

</html>
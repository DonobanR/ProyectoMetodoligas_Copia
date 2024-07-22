package util;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

public class EmailSender {

    public static void sendEmailWithAttachment(String to, String subject, String body, byte[] pdfContent) {
        final String username = "severeg.facturas@gmail.com";
        final String password = "bqrdfykwczuoggjl";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Body part
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setText(body);

            // Attachment part
            MimeBodyPart attachmentPart = new MimeBodyPart();
            DataSource source = new ByteArrayDataSource(pdfContent, "application/pdf");
            attachmentPart.setDataHandler(new DataHandler(source));
            attachmentPart.setFileName("factura.pdf");

            // Combine parts
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            Transport.send(message);
            System.out.println("Correo enviado exitosamente");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    // Clase para manejar la fuente de datos del byte array
    private static class ByteArrayDataSource implements DataSource {
        private byte[] data;
        private String type;

        public ByteArrayDataSource(byte[] data, String type) {
            this.data = data;
            this.type = type;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            return new ByteArrayInputStream(data);
        }

        @Override
        public OutputStream getOutputStream() throws IOException {
            throw new IOException("Not Supported");
        }

        @Override
        public String getContentType() {
            return type;
        }

        @Override
        public String getName() {
            return "ByteArrayDataSource";
        }
    }
}
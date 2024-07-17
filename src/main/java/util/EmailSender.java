package util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.Properties;

public class EmailSender {

    public static void enviarCorreoElectronico(String correoDestino, byte[] pdfAdjunto) {
        final String remitenteCorreo = "severeg.facturas@gmail.com";
        final String password = "SistemaSevereg2024";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitenteCorreo, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(remitenteCorreo));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correoDestino));
            message.setSubject("[FACTURA] Severeg");

            MimeBodyPart mensajeParte = new MimeBodyPart();
            mensajeParte.setText("Adjuntamos su factura en PDF.\n\n"
                    + "Los pagos del servicio pueden ser realizados únicamente en nuestros canales autorizados.\n"
                    + "El personal de Netlife no recibe ningún tipo de pago en efectivo o en cuentas personales.\n\n"
                    + "PARA REQUERIMIENTOS O CONSULTAS DE FACTURACIÓN Y COBRANZA CONTÁCTANOS");

            MimeBodyPart adjuntoParte = new MimeBodyPart();
            adjuntoParte.setContent(pdfAdjunto, "application/pdf");
            adjuntoParte.setFileName("factura.pdf");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mensajeParte);
            multipart.addBodyPart(adjuntoParte);

            message.setContent(multipart);

            Transport.send(message);

            System.out.println("Correo electrónico enviado correctamente a " + correoDestino);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

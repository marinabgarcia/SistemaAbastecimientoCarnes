/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hamal
 */
public class PagoVenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PagoVenta</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PagoVenta at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          try {
            Entidades.Pago pagoEntidad = new Entidades.Pago();
            String tipotransaccion = request.getParameter("tipoTransaccion");
            long idCompra = Long.parseLong(request.getParameter("idCompra"));
            double montoPago = Double.parseDouble(request.getParameter("montoPago"));
            String formaPago = request.getParameter("formaDePago");
            String nroCheque = request.getParameter("nroCheque");
            String nombreCheque = request.getParameter("nombreCheque");
            String bancoCheque = request.getParameter("bancoCheque");
            Date fecha = Date.valueOf(request.getParameter("fechaPago"));
            Time hora = Time.valueOf(request.getParameter("horaPago"));
            //sacar dni de la sesion
            HttpSession session = request.getSession(true);
            Entidades.Usuario usuarioConectado=(Entidades.Usuario) session.getAttribute("usuarioConectado");
            long dniUsuario = usuarioConectado.getDniUsuario();
            pagoEntidad.setHoraPago(hora);
            pagoEntidad.setFechaPago(fecha);
            pagoEntidad.setIdTransaccion(idCompra);
            pagoEntidad.setTipoTransaccion(tipotransaccion);
            pagoEntidad.setMontoPago(montoPago);
            pagoEntidad.setFormaDePago(formaPago);
            pagoEntidad.setBancoCheque(bancoCheque);
            pagoEntidad.setNroCheque(nroCheque);
            pagoEntidad.setNombreCheque(nombreCheque);
            pagoEntidad.setDniUsuario(dniUsuario);
            Negocio.Controlador con = new Negocio.Controlador();
            con.registrarPagoVenta(pagoEntidad);
            response.getWriter().write("");

        } catch (SQLException ex) {
            response.getWriter().write(ex.getMessage());
        } catch (ClassNotFoundException ex) {
            response.getWriter().write(ex.getMessage());
        } catch (ParseException ex) {
            response.getWriter().write(ex.getMessage());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Hamal
 */
public class venta extends HttpServlet {

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
            out.println("<title>Servlet venta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet venta at " + request.getContextPath() + "</h1>");
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
            String datosLineas = request.getParameter("datosLineas");
            final JSONObject obj = new JSONObject(datosLineas);
            final JSONArray datosLineasCompra = obj.getJSONArray("datos");
            final int n = datosLineasCompra.length();
            ArrayList<Entidades.LineaDeVenta> listaArticulo = new ArrayList<Entidades.LineaDeVenta>();
            for (int i = 0; i < n; ++i) {
                final JSONObject lineaVenta = datosLineasCompra.getJSONObject(i);
                Entidades.LineaDeVenta linea = new Entidades.LineaDeVenta();
                linea.setIdArticulo(lineaVenta.getInt("idArticulo"));
                linea.setCantidadLineaVenta(lineaVenta.getInt("cantidadLineaVenta"));
                linea.setPesoLineaVenta(lineaVenta.getDouble("pesoLineaVenta"));
                linea.setObservacionLineaVenta(lineaVenta.getString("observacionLineaVenta"));
                listaArticulo.add(linea);
            }
            long dniCliente = Long.parseLong(request.getParameter("dniCliente"));
            String nroRemitoVenta = request.getParameter("nroRemitoVenta");
            String nroFacturaVenta = request.getParameter("nroFacturaVenta");
            int porcentaje=0;
            //int porcentaje = Integer.parseInt(request.getParameter("porcentaje"));
            Date fechaHoy = Date.valueOf(request.getParameter("fechaHoy"));
            Time horaHoy = Time.valueOf(request.getParameter("horaHoy"));
            Negocio.Controlador con = new Negocio.Controlador();
            // trae el dni de la sesion
            HttpSession session = request.getSession(true);
            Entidades.Usuario usuarioConectado=(Entidades.Usuario) session.getAttribute("usuarioConectado");
            long dniUsuario = usuarioConectado.getDniUsuario();
            // trae el array del jsp
            con.agregarLineaVenta(dniUsuario, dniCliente, porcentaje, nroRemitoVenta, nroFacturaVenta, listaArticulo, fechaHoy, horaHoy);
            response.getWriter().write("");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FuncionalidadAdicional;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Marina
 */
public class modificarPrecio extends HttpServlet {

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
            out.println("<title>Servlet modificarPrecio</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet modificarPrecio at " + request.getContextPath() + "</h1>");
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
            int idArticulo = Integer.parseInt(request.getParameter("idArticulo"));
            double precioArticulo = Double.parseDouble(request.getParameter("precioArticulo"));
            String tipoPrecio = request.getParameter("tipoPrecio");
            Date fechaHoy = Date.valueOf(request.getParameter("fechaHoy"));
            Negocio.Controlador con = new Negocio.Controlador();

            if ("proveedor".equals(tipoPrecio)) {
                Long cuitProveedor = Long.parseLong(request.getParameter("proveedor"));
                Entidades.PreciosCompra precio = con.getOnePrecioCompra(idArticulo,cuitProveedor);
                Entidades.PreciosCompra precioNuevo = new Entidades.PreciosCompra();
                precioNuevo.setIdArticulo(idArticulo);
                precioNuevo.setFechaDesde(fechaHoy);
               //precioNuevo.setFechaHasta(null);
                precioNuevo.setMontoPrecioCompra(precioArticulo);
                precioNuevo.setCuitProveedor(cuitProveedor);

                if (precio != null) {

                    if (fechaHoy.compareTo(precio.getFechaDesde())==0) {
                        precio.setMontoPrecioCompra(precioArticulo);
                        con.modificarPrecioCompra(precio);
                    } else {

                        precio.setFechaHasta(fechaHoy);
                        con.modificarPrecioCompra(precio);
                        con.altaPrecioCompra(precioNuevo);

                    }

                } else {
                    con.altaPrecioCompra(precioNuevo);
                }

            }
            else
            {
                int idTipoCliente = Integer.parseInt(request.getParameter("cliente"));
                Entidades.PreciosVenta precio = con.getOnePrecioVenta(idArticulo,idTipoCliente);
                Entidades.PreciosVenta precioNuevo = new Entidades.PreciosVenta();
                precioNuevo.setIdArticulo(idArticulo);
                precioNuevo.setFechaDesde(fechaHoy);
               //precioNuevo.setFechaHasta(null);
                precioNuevo.setMontoPrecioVenta(precioArticulo);
                precioNuevo.setIdTipoCliente(idTipoCliente);

                if (precio != null) {

                    if (fechaHoy.compareTo(precio.getFechaDesde())==0) {
                        precio.setMontoPrecioVenta(precioArticulo);
                        con.modificarPrecioVenta(precio);
                    } else {

                        precio.setFechaHasta(fechaHoy);
                        con.modificarPrecioVenta(precio);
                        con.altaPrecioVenta(precioNuevo);

                    }

                } else {
                    con.altaPrecioVenta(precioNuevo);
                }
                
            }
            response.getWriter().print(1);
        } catch (Exception ex) {
            Logger.getLogger(modificarPrecio.class.getName()).log(Level.SEVERE, null, ex);
            response.getWriter().print(ex.getMessage());
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

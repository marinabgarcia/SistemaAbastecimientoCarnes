/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FuncionalidadAdicional;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Marina
 */
public class cargarWidgets extends HttpServlet {

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
            out.println("<title>Servlet cargarWidgets</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cargarWidgets at " + request.getContextPath() + "</h1>");
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
            double totalAdeudado=0;
            double totalPorCobrar=0;
            Negocio.Controlador con=new Negocio.Controlador();
            int cantidadClientes=con.obtenerCantidadClientes();
            int cantidadProveedores=con.obtenerCantidadProveedores();
            ArrayList<Entidades.Compra> compras=con.getAllCompras("idCompra", "asc", "");
            ArrayList<Entidades.Venta> ventas=con.getAllVentas("idVenta", "asc", "");
            for(int i=0;i<compras.size();i++)
            {
                Entidades.Compra com=compras.get(i);
                if (!com.getEstadoCompra().equals("Pagado"))
                {
                    System.out.println("compra "+com.getPrecioTotalCompra());
                    totalAdeudado=+Math.round(totalAdeudado+com.getPrecioTotalCompra());
                    System.out.println("subtotal "+totalAdeudado);
                }
            }
            System.out.println("compra "+compras.size());
             for(int i=0;i<ventas.size();i++)
            {
                Entidades.Venta com=ventas.get(i);
                if (!com.getEstadoVenta().equals("Pagado"))
                {
                    totalPorCobrar=+Math.round(totalPorCobrar+com.getPrecioTotalVenta());
                }
            }
             HttpSession session = request.getSession(true);
            Entidades.Usuario usuarioConectado=(Entidades.Usuario) session.getAttribute("usuarioConectado");
            String tipoUsuario = usuarioConectado.getTipoUsuario();
            String nombre = usuarioConectado.getNombreUsuario()+' '+usuarioConectado.getApellidoUsuario();

            response.getWriter().print(cantidadClientes+"-"+cantidadProveedores+"-"+totalPorCobrar+"-"+totalAdeudado+"-"+tipoUsuario+"-"+nombre);
        } catch (SQLException ex) {
            Logger.getLogger(cargarWidgets.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(cargarWidgets.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(cargarWidgets.class.getName()).log(Level.SEVERE, null, ex);
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

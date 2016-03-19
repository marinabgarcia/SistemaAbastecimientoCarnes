/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Datos;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Hamal
 */
public class venta {
     public Connection conexion;
    //public final static String userDb = "adminjKqSjQm";
    //public final static String passDb = "js7_I7Rw9USI";
    public String url, username, password, driver;

    //Conectar a la Base de datos
    public void conectar() throws SQLException, ClassNotFoundException {
        InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("config.xml");
        Document document;
        try {
            document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new InputSource(input));
            XPath xpath = XPathFactory.newInstance().newXPath();
            url = (String) xpath.compile("//config//jdbc//url").evaluate(document, XPathConstants.STRING);
            driver = (String) xpath.compile("//config//jdbc//driver").evaluate(document, XPathConstants.STRING);
            username = (String) xpath.compile("//config//jdbc//username").evaluate(document, XPathConstants.STRING);
            password = (String) xpath.compile("//config//jdbc//password").evaluate(document, XPathConstants.STRING);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(url, username, password);
    }

    //Desconectar a la Base de datos
    public void desconectar() throws SQLException, ClassNotFoundException {
        conexion.close();
    }
    public void guardarVenta(Entidades.Venta venta) throws SQLException, Exception
    {
    try{
        
    conectar();
            // the mysql insert statement
            String query = " insert into venta (idVenta,precioTotalVenta,fechaVenta,horaVenta,estadoVenta,nroRemitoVenta,nroFacturaVenta,dniCliente,dniUsuario,fechaVencimiento)" + " values (?,?,?,?,?,?,?,?,?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, venta.getIdVenta());
            preparedStmt.setDouble(2, venta.getPrecioTotalVenta());
            java.sql.Date sqlDate2; 
            java.util.Date javaDate1= venta.getFechaVenta();
            sqlDate2=new java.sql.Date(javaDate1.getTime());
            preparedStmt.setDate(3,sqlDate2);
            preparedStmt.setTime(4, venta.getHoraVenta());
            
            
          //  preparedStmt.setDate(5, (Date) compra.getFechaVencimientoCompra());
            preparedStmt.setString(5, venta.getEstadoVenta());
            preparedStmt.setString(6, venta.getNroFacturaVenta());
            preparedStmt.setString(7, venta.getNroFacturaVenta());
            long dni=venta.getDniCliente();
            preparedStmt.setLong(8, venta.getDniCliente());
            preparedStmt.setLong(9, venta.getDniUsuario());
            java.sql.Date sqlDate; 
            java.util.Date javaDate= venta.getFechaVencimiento();
            sqlDate=new java.sql.Date(javaDate.getTime());
            preparedStmt.setDate(10,sqlDate);
            

            // execute the preparedstatement
         
            preparedStmt.execute();
            String query2="select cuentaCorrienteCliente from cliente where dniCliente=?";
                    PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
                    preparedStmt2.setLong(1,venta.getDniCliente() );
                    ResultSet rs =preparedStmt2.executeQuery();
                    preparedStmt2.execute();
                    while(rs.next())
                    {
                    Double cuenta=rs.getDouble("cuentaCorrienteCliente");
                    Double cuentaCorriente=cuenta+venta.getPrecioTotalVenta();
         
                // the mysql insert statement
                String query3= "UPDATE cliente SET cuentaCorrienteCliente = ? WHERE dniCliente = ?";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);
              
                preparedStmt3.setDouble(1, cuentaCorriente);
                preparedStmt3.setLong(2, venta.getDniCliente());

                // execute the preparedstatement
                preparedStmt3.executeUpdate();
                    }
            
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nueva venta. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
    public void setEstadoParcial(String estado, long idVenta) throws SQLException, ClassNotFoundException, Exception {
       try{ 
        conectar();
         String query = "UPDATE venta SET estadoVenta = ? WHERE idVenta = ?";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt = conexion.prepareStatement(query);

                preparedStmt.setString(1, estado);
                preparedStmt.setLong(2, idVenta);

                // execute the preparedstatement
              int result =preparedStmt.executeUpdate();
              if (result == 0) {
                throw new Exception("Error al actualizar estado venta. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
                   
          
        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
               
        
    }
    public void setEstadoPagada(String estado, long idVenta, java.util.Date fecha, Time hora) throws SQLException, ClassNotFoundException {
       conectar();
         String query = "UPDATE venta SET estadoVenta=?, fechaUCobroVenta=?, horaUCobroVenta=? WHERE idVenta=?";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt = conexion.prepareStatement(query);

                preparedStmt.setString(1, estado);
                java.sql.Date sqlDate; 
            java.util.Date javaDate= fecha;
            sqlDate=new java.sql.Date(javaDate.getTime());
            
                preparedStmt.setDate(2, sqlDate);
                preparedStmt.setTime(3, hora);
                preparedStmt.setLong(4, idVenta);

                // execute the preparedstatement
                preparedStmt.executeUpdate();
    }

    public void setEstadoEntregado(String estado, long idVenta, java.util.Date fecha, Time hora) throws SQLException, ClassNotFoundException {
        conectar();
         String query = "UPDATE venta SET estadoVenta=?, fechaEntregaVenta=?, horaEntregaVenta=? WHERE idVenta=?";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt = conexion.prepareStatement(query);

                preparedStmt.setString(1, estado);
                java.sql.Date sqlDate; 
            java.util.Date javaDate= fecha;
            sqlDate=new java.sql.Date(javaDate.getTime());
            
                preparedStmt.setDate(2, sqlDate);
                preparedStmt.setTime(3, hora);
                preparedStmt.setLong(4, idVenta);

                // execute the preparedstatement
                preparedStmt.executeUpdate();
    }
    public ArrayList<Entidades.Venta> verificarVencimientos() throws SQLException, ClassNotFoundException {
        try {
            conectar();
            String query = "select * from venta where fechaVencimiento<curdate() and estadoVenta<>'Pagado'";
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            ResultSet rs = preparedStmt.executeQuery();
            preparedStmt.execute();
            ArrayList<Entidades.Venta> ventas = new ArrayList<Entidades.Venta>();
            while (rs.next()) {
                Entidades.Venta venta = new Entidades.Venta();
                venta.setIdVenta(rs.getLong("idVenta"));
                venta.setDniCliente(rs.getLong("dniCliente"));
                venta.setDniUsuario(rs.getLong("dniUsuario"));
                venta.setPrecioTotalVenta(rs.getDouble("precioTotalVenta"));
                venta.setFechaEntregaVentaS(rs.getString("fechaEntregaVenta"));
                venta.setFechaVentaS(rs.getString("fechaVenta"));
                venta.setFechaUCobroVentaS(rs.getString("fechaUCobroVenta"));
                venta.setFechaVencimientoS(rs.getString("fechaVencimiento"));
                venta.setHoraVentaS(rs.getString("horaVenta"));
                venta.setHoraEntregaVentaS(rs.getString("horaEntregaVenta"));
                venta.setHoraUCobroVentaS(rs.getString("horaUCobroVenta"));
                venta.setEstadoVenta(rs.getString("estadoVenta"));
                venta.setNroRemitoVenta(rs.getString("nroRemitoVenta"));
                venta.setNroFacturaVenta(rs.getString("nroFacturaVenta"));

                ventas.add(venta);

            }
            desconectar();
            return ventas;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
    }
    public ArrayList<Entidades.Venta> getAllVentas(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM venta ven inner join cliente cli on ven.dniCliente=cli.dniCliente order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM venta ven inner join cliente cli on ven.dniCliente=cli.dniCliente where " + "estadoVenta like \"" + search + "%\" OR" + " fechaEntregaVenta like \"" + search + "%\" OR" + " fechaVenta like \"" + search + "%\" OR" + " fechaVencimientoVenta like \"" + search + "%\" OR" + " com.dniCliente like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Venta> ventas = new ArrayList<Entidades.Venta>();
            while (rs.next()) {
               Entidades.Venta venta = new Entidades.Venta();
                venta.setIdVenta(rs.getLong("idVenta"));
                venta.setIdVentaS(rs.getString("idVenta"));
                venta.setDniCliente(rs.getLong("dniCliente"));
                venta.setCuitCliente(rs.getLong("cuitCliente"));
                venta.setDniUsuario(rs.getLong("dniUsuario"));
                venta.setPrecioTotalVenta(rs.getDouble("precioTotalVenta"));
                venta.setFechaEntregaVentaS(rs.getString("fechaEntregaVenta"));
                venta.setFechaVentaS(rs.getString("fechaVenta"));
                venta.setFechaUCobroVentaS(rs.getString("fechaUCobroVenta"));
                venta.setFechaVencimientoVentaS(rs.getString("fechaVencimiento"));
                venta.setHoraVentaS(rs.getString("horaVenta"));
                venta.setHoraEntregaVentaS(rs.getString("horaEntregaVenta"));
                venta.setHoraUCobroVentaS(rs.getString("horaUCobroVenta"));
                venta.setEstadoVenta(rs.getString("estadoVenta"));
                venta.setNroRemitoVenta(rs.getString("nroRemitoVenta"));
                venta.setNroFacturaVenta(rs.getString("nroFacturaVenta"));
                venta.setCliente(rs.getString("nombreCliente")+" "+rs.getString("apellidoCliente"));
                venta.setRazonSocialCliente(rs.getString("razonSocialCliente"));

                ventas.add(venta);
            }
            desconectar();
            return ventas;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }
    public double obtenerPrecioVenta(long idVenta) throws SQLException, ClassNotFoundException {
        conectar();

        String query = "select precioTotalVenta from venta where idVenta=?";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        preparedStmt.setLong(1, idVenta);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            Double precio = rs.getDouble("precioTotalVenta");
            return precio;
        }
        return 0;

    }
     public void eliminarVenta(long idVenta) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "call eliminarVenta(?)";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, idVenta);

            // execute the preparedstatement
            ps.executeUpdate();

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
    }
     public String ventaMensualActual() throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql = "SELECT sum(precioTotalVenta) as monto,MONTH(fechaVenta) as mes,YEAR(fechaVenta) as anio FROM venta where YEAR(fechaVenta)=? group by MONTH(fechaVenta), YEAR(fechaVenta) order by MONTH(fechaVenta) asc;";
            PreparedStatement ps = conexion.prepareStatement(sql);
            Calendar fecha = new GregorianCalendar();
            ps.setInt(1, fecha.get(Calendar.YEAR));
            ResultSet rs = ps.executeQuery();
            int cont = 1;
            String consumos = "";
            if (rs.next()) {
                int mes = rs.getInt("mes");
                for (int x = 1; x < mes; x++) {
                    consumos += 0;
                    consumos += ",";
                }
                consumos += (double)Math.round(rs.getDouble("monto")*100)/100;
                consumos += ",";
            }
            while (rs.next()) {
                consumos += (double)Math.round(rs.getDouble("monto")*100)/100;
                consumos += ",";
            }
            desconectar();
            return consumos;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception E) {
            throw E;
        } finally {
            desconectar();
        }
    }
     
      public Entidades.Venta getOne(long idVenta)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql = "SELECT * FROM venta ven where idVenta = ?;";
    
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, idVenta);
            ResultSet rs = ps.executeQuery();
        
            Entidades.Venta venta = new Entidades.Venta();
            while (rs.next()) {
                venta.setIdVenta(rs.getLong("idVenta"));
                venta.setIdVentaS(rs.getString("idVenta"));
                venta.setDniCliente(rs.getLong("dniCliente"));
//              venta.setCuitCliente(rs.getLong("cuitCliente"));
                venta.setDniUsuario(rs.getLong("dniUsuario"));
                venta.setPrecioTotalVenta(rs.getDouble("precioTotalVenta"));
                venta.setFechaEntregaVentaS(rs.getString("fechaEntregaVenta"));
                venta.setFechaEntregaVenta(rs.getDate("fechaEntregaVenta"));
                venta.setFechaVentaS(rs.getString("fechaVenta"));
                venta.setFechaUCobroVentaS(rs.getString("fechaUCobroVenta"));
                venta.setFechaVencimientoVentaS(rs.getString("fechaVencimiento"));
                venta.setHoraVentaS(rs.getString("horaVenta"));
                venta.setHoraEntregaVentaS(rs.getString("horaEntregaVenta"));
                venta.setHoraEntregaVenta(rs.getTime("horaEntregaVenta"));
                venta.setHoraUCobroVentaS(rs.getString("horaUCobroVenta"));
                venta.setEstadoVenta(rs.getString("estadoVenta"));
                venta.setNroRemitoVenta(rs.getString("nroRemitoVenta"));
                venta.setNroFacturaVenta(rs.getString("nroFacturaVenta"));
//              venta.setCliente(rs.getString("nombreCliente")+" "+rs.getString("apellidoCliente"));
//              venta.setRazonSocialCliente(rs.getString("razonSocialCliente"));

            }
            desconectar();
            return venta;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }
  
}

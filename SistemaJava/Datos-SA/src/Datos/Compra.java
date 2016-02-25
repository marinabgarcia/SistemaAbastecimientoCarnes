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
public class Compra {

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

    public void guardarCompra(Entidades.Compra compra) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = " insert into compra (idCompra,precioTotalCompraCalculado,fechaEntregaCompra,horaEntregaCompra,estadoCompra,nroRemitoCompra,nroFacturaCompra,cuitProveedor,dniUsuario,fechaVencimientoCompra,precioTotalCompra)" + " values (?,?,?,?,?,?,?,?,?,?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, compra.getIdCompra());
            preparedStmt.setDouble(2, compra.getPrecioTotalCompraCalculado());
            java.sql.Date sqlDate2;
            java.util.Date javaDate1 = compra.getFechaEntregaCompra();
            sqlDate2 = new java.sql.Date(javaDate1.getTime());
            preparedStmt.setDate(3, sqlDate2);
            preparedStmt.setTime(4, compra.getHoraEntregaCompra());

            //  preparedStmt.setDate(5, (Date) compra.getFechaVencimientoCompra());
            preparedStmt.setString(5, compra.getEstadoCompra());
            preparedStmt.setString(6, compra.getNroFacturaCompra());
            preparedStmt.setString(7, compra.getNroFacturaCompra());
            preparedStmt.setLong(8, compra.getCuitProveedor());
            preparedStmt.setLong(9, compra.getDniUsuario());
            java.sql.Date sqlDate;
            java.util.Date javaDate = compra.getFechaVencimientoCompra();
            sqlDate = new java.sql.Date(javaDate.getTime());
            preparedStmt.setDate(10, sqlDate);
            preparedStmt.setDouble(11, compra.getPrecioTotalCompra());

            // execute the preparedstatement
            preparedStmt.execute();

            String query2 = "select cuentaCorrienteProveedor from proveedor where cuitProveedor=?";
            PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
            preparedStmt2.setLong(1, compra.getCuitProveedor());
            ResultSet rs = preparedStmt2.executeQuery();
            preparedStmt2.execute();
            while (rs.next()) {
                Double cuenta = rs.getDouble("cuentaCorrienteProveedor");
                Double cuentaCorriente = cuenta - compra.getPrecioTotalCompra();

                // the mysql insert statement
                String query3 = "UPDATE proveedor SET cuentaCorrienteProveedor = ? WHERE cuitProveedor = ?";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);

                preparedStmt3.setDouble(1, cuentaCorriente);
                preparedStmt3.setLong(2, compra.getCuitProveedor());

                // execute the preparedstatement
                preparedStmt3.executeUpdate();
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nueva compra. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
    /*
     public void actualizarCCProveedor(Double precioRemito, Long idCompra, Double precioCalculado) throws SQLException, Exception {
     try {
     conectar();

     String query4 = "select cuentaCorrienteProveedor from proveedor inner join compra where idCompra=?";
     PreparedStatement preparedStmt4 = conexion.prepareStatement(query4);
     preparedStmt4.setLong(1, idCompra);
     ResultSet rs = preparedStmt4.executeQuery();
     preparedStmt4.execute();
     while (rs.next()) {
     Double cuenta = rs.getDouble("cuentaCorrienteProveedor");
     Double cuentaCorriente = cuenta - precioRemito + precioCalculado;

     // the mysql insert statement
     String query3 = "UPDATE Proveedor inner join compra SET cuentaCorrienteProveedor = ?  WHERE idCompra = ?";

     // create the mysql insert preparedstatement
     PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);

     preparedStmt3.setDouble(1, cuentaCorriente);
     preparedStmt3.setLong(2, idCompra);

     // execute the preparedstatement
     preparedStmt3.executeUpdate();
     }
     desconectar();

     } catch (SQLException ex) {
     throw ex;
     } catch (Exception Ex) {
     Exception ExcepcionManejada = new Exception("Error al actualizar el precio de la compra", Ex);
     throw ExcepcionManejada;
     } finally {
     desconectar();
     }
     }
     */

    public double obtenerPrecioCompra(long idCompra) throws SQLException, ClassNotFoundException {
        conectar();

        String query = "select precioTotalCompra from compra where idCompra=?";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        preparedStmt.setLong(1, idCompra);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            Double precio = rs.getDouble("precioTotalCompra");
            return precio;
        }
        return 0;

    }

    public void setEstadoParcial(String estado, long idCompra) throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String query = "UPDATE compra SET estadoCompra = ? WHERE idCompra = ?";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);

            preparedStmt.setString(1, estado);
            preparedStmt.setLong(2, idCompra);

            // execute the preparedstatement
            int result = preparedStmt.executeUpdate();
            if (result == 0) {
                throw new Exception("Error al actualizar estado compra. Vuelva a intentarlo.");
            } else {
                desconectar();
            }

        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void setEstadoPagada(String estado, long idCompra, java.util.Date fecha, Time hora) throws SQLException, ClassNotFoundException {
        conectar();
        String query = "UPDATE compra SET estadoCompra=?, fechaUPagoCompra=?,  horaUPagoCompra=? WHERE idCompra = ?";

        // create the mysql insert preparedstatement
        PreparedStatement preparedStmt = conexion.prepareStatement(query);

        preparedStmt.setString(1, estado);
        java.sql.Date sqlDate;
        java.util.Date javaDate = fecha;
        sqlDate = new java.sql.Date(javaDate.getTime());

        preparedStmt.setDate(2, sqlDate);
        preparedStmt.setTime(3, hora);
        preparedStmt.setLong(4, idCompra);

        // execute the preparedstatement
        preparedStmt.executeUpdate();
    }

    public ArrayList<Entidades.Compra> getAllCompras(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM compra com inner join proveedor pro on com.cuitProveedor=pro.cuitProveedor order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM compra com inner join proveedor pro on com.cuitProveedor=pro.cuitProveedor where " + "estadoCompra like \"" + search + "%\" OR" + " fechaEntregaCompra like \"" + search + "%\" OR" + " fechaVencimientoCompra like \"" + search + "%\" OR" + " com.cuitProveedor like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Compra> compras = new ArrayList<Entidades.Compra>();
            while (rs.next()) {
                Entidades.Compra compra = new Entidades.Compra();
                compra.setIdCompra(rs.getLong("idCompra"));
                compra.setIdCompraS(rs.getString("idCompra"));
                compra.setCuitProveedor(rs.getLong("cuitProveedor"));
                compra.setDniUsuario(rs.getLong("dniUsuario"));
                compra.setPrecioTotalCompraCalculado(rs.getDouble("precioTotalCompraCalculado"));
                compra.setPrecioTotalCompra(rs.getDouble("precioTotalCompra"));
                compra.setFechaEntregaCompraS(rs.getDate("fechaEntregaCompra").toString());
                compra.setFechaUPagoCompraS(rs.getString("fechaUPagoCompra"));
                compra.setFechaVencimientoCompraS(rs.getString("fechaVencimientoCompra"));
                compra.setHoraEntregaCompraS(rs.getString("horaEntregaCompra"));
                compra.setHoraUPagoCompraS(rs.getString("horaUPagoCompra"));
                compra.setEstadoCompra(rs.getString("estadoCompra"));
                compra.setNroRemitoCompra(rs.getString("nroRemitoCompra"));
                compra.setNroFacturaCompra(rs.getString("nroFacturaCompra"));
                compra.setProveedor(rs.getString("nombreProveedor") + ' ' + rs.getString("apellidoProveedor"));
                compras.add(compra);
            }
            desconectar();
            return compras;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void eliminarCompra(long idCompra) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "call eliminarCompra(?)";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, idCompra);

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

    public ArrayList<Entidades.Compra> verificarVencimientos() throws SQLException, ClassNotFoundException {
        try {
            conectar();
            String query = "select * from compra where fechaVencimientoCompra<curdate() and estadoCompra<>'Pagado'";
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            ResultSet rs = preparedStmt.executeQuery();
            preparedStmt.execute();
            ArrayList<Entidades.Compra> compras = new ArrayList<Entidades.Compra>();
            while (rs.next()) {
                Entidades.Compra compra = new Entidades.Compra();
                compra.setIdCompra(rs.getLong("idCompra"));
                compra.setCuitProveedor(rs.getLong("cuitProveedor"));
                compra.setDniUsuario(rs.getLong("dniUsuario"));
                compra.setPrecioTotalCompraCalculado(rs.getDouble("precioTotalCompraCalculado"));
                compra.setPrecioTotalCompra(rs.getDouble("precioTotalCompra"));
                compra.setFechaEntregaCompraS(rs.getDate("fechaEntregaCompra").toString());
                compra.setFechaUPagoCompraS(rs.getString("fechaUPagoCompra"));
                compra.setFechaVencimientoCompraS(rs.getString("fechaVencimientoCompra"));
                compra.setHoraEntregaCompraS(rs.getString("horaEntregaCompra"));
                compra.setHoraUPagoCompraS(rs.getString("horaUPagoCompra"));
                compra.setEstadoCompra(rs.getString("estadoCompra"));
                compra.setNroRemitoCompra(rs.getString("nroRemitoCompra"));
                compra.setNroFacturaCompra(rs.getString("nroFacturaCompra"));

                compras.add(compra);

            }
            desconectar();
            return compras;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }
    
     public String compraMensualActual() throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql = "SELECT sum(precioTotalCompra) as monto,MONTH(fechaEntregaCompra) as mes,YEAR(fechaEntregaCompra) as anio FROM compra where YEAR(fechaEntregaCompra)=? group by MONTH(fechaEntregaCompra), YEAR(fechaEntregaCompra) order by MONTH(fechaEntregaCompra) asc;";
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

}

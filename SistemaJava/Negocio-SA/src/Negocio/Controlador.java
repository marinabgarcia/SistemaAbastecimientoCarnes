/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.Articulo;
import Entidades.LineaDeCompra;
import Entidades.LineaDeVenta;
import Entidades.Usuario;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Marina
 */
public class Controlador {

    private CatalogoDeProveedores cdp = new CatalogoDeProveedores();
    private CatalogoDeClientes cdc = new CatalogoDeClientes();
    private CatalogoDeArticulos cda = new CatalogoDeArticulos();
    private CatalogoDeCalidades cdcalidad = new CatalogoDeCalidades();
    private CatalogoDeTiposDeCliente cdt = new CatalogoDeTiposDeCliente();
    private CatalogoDeProvincias cdprovincia = new CatalogoDeProvincias();
    private CatalogoDeLocalidades cdl = new CatalogoDeLocalidades();
    private CatalogoDeLineasDeCompra cdlcompra = new CatalogoDeLineasDeCompra();
    private CatalogoDeCompras cdcompra = new CatalogoDeCompras();
    private CatalogoDePreciosCompra cdpc = new CatalogoDePreciosCompra();
    private CatalogoDePreciosVenta cdpv = new CatalogoDePreciosVenta();
    private CatalogoDeLineasDeVenta cdlventa = new CatalogoDeLineasDeVenta();
    private CatalogoDeVentas cdventa = new CatalogoDeVentas();
    private CatalogoDePagos cdpagos = new CatalogoDePagos();
    private CatalogoDeUsuarios cdu = new CatalogoDeUsuarios();
    private CatalogoDeFraccionamientos cdf = new CatalogoDeFraccionamientos();
    public double precioTotalCompraCalculado;
    private long idCompra;
    public double precioTotalVentaCalculado;
    private long idVenta;

    //-------------ABM PROVEEDOR----------------------------
    public void altaProveedor(Entidades.Proveedor pro) throws Exception {
        cdp.altaDeProveedor(pro);
    }

    public int modificarProveedor(Entidades.Proveedor pro) throws Exception {
        return cdp.modificacionDeProveedor(pro);
    }

    public int eliminarProveedor(Long cuit) throws Exception {
        return cdp.bajaDeProveedor(cuit);
    }

    public int activarProveedor(Long cuit) throws Exception {
        return cdp.activarProveedor(cuit);
    }

    public ArrayList<Entidades.Proveedor> getTotalProveedores(String query, String filtro) throws Exception {
        return cdp.getTotalProveedores(query, filtro);
    }

    public ArrayList<Entidades.Proveedor> getProveedores(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return cdp.getProveedores(page, rp, sortname, sortorder, query, filtro);
    }

    public ArrayList<Entidades.Proveedor> getAllProveedores() throws Exception {
        return cdp.getAllProveedores();
    }

    public ArrayList<Entidades.Proveedor> getProveedoresB(String sortname, String sortorder, String query) throws Exception {
        return cdp.getProveedoresB(sortname, sortorder, query);
    }

    public int obtenerCantidadProveedores() throws SQLException, ClassNotFoundException {
        return cdp.obtenerCantidadProveedores();
    }

    //-------------ABM USUARIO----------------------------
    public void altaUsuario(Entidades.Usuario us) throws Exception {
        cdu.altaDeUsuario(us);
    }

    public int modificarUsuario(Entidades.Usuario us) throws Exception {
        return cdu.modificacionDeUsuario(us);
    }

    public int eliminarUsuario(Long dni, Date fb) throws Exception {
        return cdu.bajaDeUsuario(dni, fb);
    }

    public int activarUsuario(Long dni) throws Exception {
        return cdu.activarUsuario(dni);
    }

    public ArrayList<Entidades.Usuario> getTotalUsuarios(String query, String filtro) throws Exception {
        return cdu.getTotalUsuarios(query, filtro);
    }

    public ArrayList<Entidades.Usuario> getUsuarios(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return cdu.getUsuarios(page, rp, sortname, sortorder, query, filtro);
    }

    public Entidades.Usuario identificarUsuario(Long dni, String hash) throws ClassNotFoundException, Exception {
        Entidades.Usuario usu = new Entidades.Usuario();
        usu = cdu.buscarUsuario(dni, hash);
        return usu;
    }

    public ArrayList<Usuario> getUsuariosB(String sortname, String sortorder, String query) throws Exception {
        return cdu.getUsuariosB(sortname, sortorder, query);
    }

    //-------------ABM CLIENTE----------------------------
    public void altaCliente(Entidades.Cliente cli) throws Exception {
        cdc.altaDeCliente(cli);
    }

    public int modificarCliente(Entidades.Cliente cli) throws Exception {
        return cdc.modificacionDeCliente(cli);
    }

    public int eliminarCliente(Long dni) throws Exception {
        return cdc.bajaDeCliente(dni);
    }

    public int activarCliente(Long dni) throws Exception {
        return cdc.activarCliente(dni);
    }

    public ArrayList<Entidades.Cliente> getTotalClientes(String query, String filtro) throws Exception {
        return cdc.getTotalClientes(query, filtro);
    }

    public ArrayList<Entidades.Cliente> getClientes(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return cdc.getClientes(page, rp, sortname, sortorder, query, filtro);
    }

    public ArrayList<Entidades.Cliente> getClientesB(String sortname, String sortorder, String search) throws Exception {
        return cdc.getClientesB(sortname, sortorder, search);
    }

    public int obtenerCantidadClientes() throws SQLException, ClassNotFoundException {
        return cdc.obtenerCantidadClientes();
    }
    
    public Entidades.Cliente getOneCliente(Long dniCliente) throws Exception
    {
        return cdc.getOneCliente(dniCliente);
    }

    //-------------ABM ARTICULO---------------------------

    public Entidades.Articulo getOneArticulo(int idArticulo, long cuitProveedor) throws Exception {
        return cda.getOneArticulo(idArticulo, cuitProveedor);
    }
     public Entidades.Articulo getOneArticuloPrecioVenta(int idArticulo, long idTipoCliente) throws Exception {
        return cda.getOneArticuloPrecioVenta(idArticulo, idTipoCliente);
    }

    public void altaArticulo(Entidades.Articulo art) throws Exception {
        cda.altaDeArticulo(art);
    }

    public int modificarArticulo(Entidades.Articulo art) throws Exception {
        return cda.modificacionDeArticulo(art);
    }

    public int eliminarArticulo(int id) throws Exception {
        return cda.bajaDeArticulo(id);
    }

    public int activarArticulo(int id) throws Exception {
        return cda.activarArticulo(id);
    }

    public int recuperarUltimoIdArticulo() throws Exception {
        return cda.recuperarUltimoIdArticulo();
    }

    public ArrayList<Articulo> getTotalArticulos(String query, String filtro) throws Exception {
        return cda.getTotalArticulos(query, filtro);
    }

    public ArrayList<Articulo> getArticulos(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return cda.getArticulos(page, rp, sortname, sortorder, query, filtro);
    }

    public ArrayList<Articulo> getArticulosPrecioCompra(String sortname, String sortorder, String searchPhrase, Long cuitProveedor) throws Exception {
        return cda.getArticulosPrecioCompra(sortname, sortorder, searchPhrase, cuitProveedor);
    }

    public ArrayList<Articulo> getArticulosPrecioVenta(String sortname, String sortorder, String searchPhrase, int idTipoCliente) throws Exception {
        return cda.getArticulosPrecioVenta(sortname, sortorder, searchPhrase, idTipoCliente);
    }

    public ArrayList<Articulo> getArticulosB(String sortname, String sortorder, String searchPhrase) throws Exception {
        return cda.getArticulosB(sortname, sortorder, searchPhrase);
    }

    //-------------ABM CALIDADES---------------------------

    public ArrayList<Entidades.Calidad> getAllCalidades() throws SQLException, ClassNotFoundException, Exception {
        return cdcalidad.getAllCalidades();
    }

    //-------------ABM TIPOS DE CLIENTE---------------------------
    public ArrayList<Entidades.TipoCliente> getAllTipos() throws SQLException, ClassNotFoundException, Exception {
        return cdt.getAllTipos();
    }

    public int modificarTipoCliente(Entidades.TipoCliente tipo) throws SQLException, Exception {
        return cdt.modificarTipoCliente(tipo);
    }

    //-------------PROVINCIAS---------------------------
    public ArrayList<Entidades.Localidad> getAllLocalidades(int idProvincia) throws ClassNotFoundException, Exception {
        return cdl.getAll(idProvincia);
    }
//-------------ABM LOCALIDADES---------------------------

    public ArrayList<Entidades.Provincia> getAllProvincias() throws ClassNotFoundException, Exception {
        return cdprovincia.getAll();
    }

    //-------------ABM PRECIOSCOMPRA---------------------------
    public void altaPrecioCompra(Entidades.PreciosCompra precioCompraNuevo) throws Exception {
        cdpc.altaPrecioCompra(precioCompraNuevo);
    }

    public int modificarPrecioCompra(Entidades.PreciosCompra precioCompra) throws Exception {
        return cdpc.modificarPrecioCompra(precioCompra);
    }

    public Entidades.PreciosCompra getOnePrecioCompra(int idArticulo, long cuitProveedor) throws Exception {
        return cdpc.getOnePrecioCompra(idArticulo, cuitProveedor);
    }

    public ArrayList<Entidades.PreciosCompra> getAllPreciosCVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        return cdpc.getAllPreciosCVigentes(idArticulo);
    }

    //-------------ABM PRECIOSVENTA---------------------------
    public void altaPrecioVenta(Entidades.PreciosVenta precioVentaNuevo) throws Exception {
        cdpv.altaPrecioVenta(precioVentaNuevo);
    }

    public int modificarPrecioVenta(Entidades.PreciosVenta precioVenta) throws Exception {
        return cdpv.modificarPrecioVenta(precioVenta);
    }

    public Entidades.PreciosVenta getOnePrecioVenta(int idArticulo, int idTipoCliente) throws Exception {
        return cdpv.getOnePrecioVenta(idArticulo, idTipoCliente);
    }

    public void restablecerListaPrecios(int idTipoCliente, java.sql.Date fechaHoy) throws Exception {
        cdpv.restablecerListaPrecios(idTipoCliente, fechaHoy);
    }

    public void restablecerListaPreciosGenericos(long cuitProveedor, java.sql.Date fechaHoy) throws Exception {
        cdpv.restablecerListaPreciosGenericos(cuitProveedor, fechaHoy);
    }

    public ArrayList<Entidades.PreciosVenta> getAllPreciosVVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        return cdpv.getAllPreciosVVigentes(idArticulo);
    }
//-------------ABM COMPRAS---------------------------

    public ArrayList<Entidades.Compra> getAllCompras(String sortname, String sortorder, String search) throws Exception {
        return cdcompra.getAllCompras(sortname, sortorder, search);
    }

    public ArrayList<Entidades.Compra> verificarVencimientosCompra() throws Exception {
        return cdcompra.verificarVencimientos();
    }

    public ArrayList<LineaDeCompra> agregarLineaCompra(long dniUsuario, long idProveedor, String nroRemito, String nroFactura, ArrayList< Entidades.LineaDeCompra> listaLinea, Date fechaHoy, Time horaHoy, double totalCompraRemito) throws Exception {

        long numero = idProveedor % 1000;
        String concatenado = "" + fechaHoy.toString().replace("-", "") + horaHoy.toString().replace(":", "") + numero + "";
        idCompra = Long.parseLong(concatenado);
        for (int i = 0; i < listaLinea.size(); i++) {
            Datos.PrecioCompra pc = new Datos.PrecioCompra();
            Entidades.LineaDeCompra listap = new Entidades.LineaDeCompra();
            listap = listaLinea.get(i);
            // -----------obtener idcompra y idlineadecompraa-----------------------
            int secuencial = i; //Aca ir a buscar el numero secuencial
            String concatenado2 = "" + idCompra + secuencial + "";
            long idLineaCompra = Long.parseLong(concatenado2);
            listap.setIdLineaCompra(idLineaCompra);
            listap.setIdCompra(idCompra);
            //----------------------------------------------------------------------
            //----------------------obtener precio----------------------------------
            double precioCompra = pc.obtenerPrecio(listap.getIdArticulo(), idProveedor);
            double precioLineaCompra = listap.getPesoLineaCompra() * precioCompra;

            precioTotalCompraCalculado = precioTotalCompraCalculado + precioLineaCompra;
            listap.setPrecioLineaCompra(precioLineaCompra);
        }

        //ir a guardar la compra
        cdcompra.guardarCompra(dniUsuario, idProveedor, idCompra, nroRemito, nroFactura, precioTotalCompraCalculado, fechaHoy, horaHoy, totalCompraRemito);
        cdlcompra.nuevaLineaCompra(listaLinea);
        return listaLinea;
    }

    public void guardarFraccionamiento(long idLineaCompra, ArrayList<Articulo> listaArticulo, int cantidadFraccionada, int idArticuloAFraccionar) throws SQLException, ClassNotFoundException, Exception {
        //long  idfraccionamiento;

        long idfraccionamiento = cdf.crearFraccionamiento(idLineaCompra, cantidadFraccionada);
        int ultimaFraccion = cdlcompra.obtenerUltimaFraccion(idLineaCompra);
        int nuevaFraccion = ultimaFraccion + cantidadFraccionada;
        cdlcompra.guardarCantidadFraccionada(idLineaCompra, nuevaFraccion);
        int idArticuloRes = idArticuloAFraccionar; // ver como identificar al articulo de mediaRes lo tome de interfaz

        cda.decrementarStock(idArticuloRes, cantidadFraccionada);
        for (int i = 0; i < listaArticulo.size(); i++) {
            Entidades.Articulo Articulo = new Entidades.Articulo();
            Articulo = listaArticulo.get(i);
            int idArticulo = Articulo.getIdArticulo();
            int cantidad = Articulo.getCantidadFraccionada();
            cdf.guardarFraccionamientos(idArticulo, idfraccionamiento, cantidad);
            cda.incrementarStock(idArticulo, cantidad);

        }
    }

    public ArrayList<Entidades.LineaDeCompra> getAllFraccionamientos(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
        return cdf.getAllFraccionamientos(sortname, sortorder, search, idCompra);
    }

    public long agregarLineaVenta(long dniUsuario, long idCliente, int porcentaje, String nroRemito, String nroFactura, ArrayList<LineaDeVenta> listaLinea, Date fechaHoy, Time horaHoy) throws SQLException, ClassNotFoundException, Exception {
        long numero = idCliente % 1000;
        String concatenado = "" + fechaHoy.toString().replace("-", "") + horaHoy.toString().replace(":", "") + numero + "";
        idVenta = Long.parseLong(concatenado);
        for (int i = 0; i < listaLinea.size(); i++) {
            Datos.PrecioVenta pv = new Datos.PrecioVenta();
            Entidades.LineaDeVenta listap = new Entidades.LineaDeVenta();
            listap = listaLinea.get(i);
            // -----------obtener idcompra y idlineadecompraa-----------------------
            int secuencial = i; //Aca ir a buscar el numero secuencial
            String concatenado2 = "" + idVenta + secuencial + "";
            long idLineaVenta = Long.parseLong(concatenado2);
            listap.setIdLineaVenta(idLineaVenta);
            listap.setIdVenta(idVenta);
            //----------------------------------------------------------------------
            //----------------------obtener precio----------------------------------
            long idTipoCliente = cdc.devolverTipoCliente(idCliente);
            // ver si ir a buscar el porcentaje aca o no  
            double precioVenta = pv.obtenerPrecio(listap.getIdArticulo(), idTipoCliente);
            //double precioVentaPorcentaje = precioVenta + (precioVenta * porcentaje) / 100;
            //double precioLineaVenta = listap.getCantidadLineaVenta() * listap.getPesoLineaVenta() * precioVentaPorcentaje;
            double precioLineaVenta = precioVenta * listap.getPesoLineaVenta();
            precioTotalVentaCalculado = precioTotalVentaCalculado + precioLineaVenta;
            listap.setPrecioLineaVenta(precioLineaVenta);
        }
        //ir a guardar la compra
        cdventa.guardarVenta(dniUsuario, idVenta, idCliente, nroRemito, nroFactura, precioTotalVentaCalculado, fechaHoy, horaHoy);
        cdlventa.nuevaLineaVenta(listaLinea);
        return idVenta;

    }

    public ArrayList<Entidades.Venta> verificarVencimientosVenta() throws SQLException, ClassNotFoundException {
        return cdventa.verificarVencimientos();
    }

    public ArrayList<Entidades.Venta> getAllVentas(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        return cdventa.getAllVentas(sortname, sortorder, search);
    }

    public ArrayList<Entidades.LineaDeCompra> getAllLineas(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
        return cdlcompra.getAllLineas(sortname, sortorder, search, idCompra);
    }

    public ArrayList<Entidades.LineaDeVenta> getAllLineasVenta(String sortname, String sortorder, String search, long idVenta)
            throws SQLException, ClassNotFoundException, Exception {
        return cdlventa.getAllLineas(sortname, sortorder, search, idVenta);
    }

    public void eliminarCompra(long idCompra) throws SQLException, Exception {
        cdcompra.eliminarCompra(idCompra);
    }

    public void eliminarVenta(long idVenta) throws SQLException, Exception {
        cdventa.eliminarVenta(idVenta);
    }

    public void registrarPago(Entidades.Pago pago) throws SQLException, ClassNotFoundException, Exception {
        cdpagos.guardarPago(pago);
        ArrayList<Entidades.Pago> pagos = cdpagos.getAllPagos("idTransaccion", "asc", "", pago.getIdTransaccion());
        cdcompra.actualizarEstadoCompra(pago, pagos);
    }

    public void registrarPagoVenta(Entidades.Pago pago) throws ClassNotFoundException, Exception {
        cdpagos.guardarPago(pago);
        ArrayList<Entidades.Pago> pagos = cdpagos.getAllPagos("idTransaccion", "asc", "", pago.getIdTransaccion());
        cdventa.actualizarEstadoVenta(pago, pagos);

    }

    public ArrayList<Entidades.Pago> getAllPagos(String sortname, String sortorder, String search, long idTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        return cdpagos.getAllPagos(sortname, sortorder, search, idTransaccion);
    }

    public ArrayList<Entidades.Pago> getAllPagosTipo(String sortname, String sortorder, String search, String tipoTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        return cdpagos.getAllPagosTipo(sortname, sortorder, search, tipoTransaccion);
    }

    public void registrarVentaEntregada(long idVenta, Date fecha, Time horas, String estado) throws SQLException, ClassNotFoundException {
        cdventa.registrarVentaEntregada(idVenta, fecha, horas, estado);
    }

    public void eliminarFraccionamiento(long idFraccionamiento) throws Exception {
        cdf.eliminarFraccionamiento(idFraccionamiento);
    }
    
      public String ventaMensualActual() throws SQLException, ClassNotFoundException, Exception {
        return cdventa.ventaMensualActual();
    }
      public String compraMensualActual() throws SQLException, ClassNotFoundException, Exception {
          return cdcompra.compraMensualActual();
      }

    public void eliminarPago(long idPago,Date fechaPago,Time horaPago) throws Exception {
          cdpagos.eliminarPago(idPago,fechaPago,horaPago);     
   }

}

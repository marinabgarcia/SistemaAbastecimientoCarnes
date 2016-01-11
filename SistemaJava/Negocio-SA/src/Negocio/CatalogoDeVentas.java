/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.Pago;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;

/**
 *
 * @author Hamal
 */
public class CatalogoDeVentas {

    Datos.venta ventaDatos = new Datos.venta();

    public void guardarVenta(long dniUsuario,long idVenta, long dniCliente,  String nroRemito, String nroFactura, double precioTotalVentaCalculado, Date fechaHoy, Time horaHoy) throws ParseException, Exception {
        Entidades.Venta venta = new Entidades.Venta();
        Datos.venta VentaDatos = new Datos.venta();
        venta.setIdVenta(idVenta);
        venta.setNroFacturaVenta(nroFactura);
        venta.setNroRemitoVenta(nroRemito);
        venta.setPrecioTotalVenta(precioTotalVentaCalculado);
        venta.setFechaVenta(fechaHoy);
        Calendar c = Calendar.getInstance();
        c.setTime(fechaHoy);
        c.add(Calendar.DATE, 7);
        java.sql.Date fechaVencimiento = new java.sql.Date(c.getTimeInMillis());
        venta.setFechaVencimiento(fechaVencimiento);
        venta.setHoraVenta(horaHoy);
        //setiar vencimiento
        venta.setDniUsuario(dniUsuario);
        venta.setDniCliente(dniCliente);
        venta.setEstadoVenta("Registrado");
        // ir a la base de datos a guardar
        VentaDatos.guardarVenta(venta);
    }

    public void actualizarEstadoVenta(Entidades.Pago pago,ArrayList<Entidades.Pago> pagosRealizados) throws SQLException, ClassNotFoundException, Exception {
        Datos.venta ventaDatos = new Datos.venta();
        Datos.Cliente clienteDatos = new Datos.Cliente();
        long idVenta = pago.getIdTransaccion();
        //double ctacte = clienteDatos.obtenerCtaCte(idVenta);
        //double precioTotalCompra=compraDatos.obtenerPrecioCompra(idCompra);
        double precioTotalVenta = ventaDatos.obtenerPrecioVenta(idVenta);
        //double precioTotalCompra=compraDatos.obtenerPrecioCompra(idCompra);
        double totalPagos = 0;
        for (Entidades.Pago pagoRealizado : pagosRealizados) {
            totalPagos = totalPagos + pagoRealizado.getMontoPago();
        }
        double resto = precioTotalVenta - totalPagos;
        String estado = "";
        if (resto > 0) {
            estado = "Pago Parcial";
        }
        if (resto <= 0) {
            estado = "Pagado";

        }
         //lo cambie de esta forma para que siempre se setea fechaUPago y horaUPago
        java.util.Date fecha = pago.getFechaPago();
        Time hora = pago.getHoraPago();
        ventaDatos.setEstadoPagada(estado, idVenta, fecha, hora);
        clienteDatos.actualizoCtaCte(resto, idVenta);

        //return resto;

    }

    void registrarVentaEntregada(long idVenta, Date fecha, Time hora, String estado) throws SQLException, ClassNotFoundException {

        ventaDatos.setEstadoEntregado(estado, idVenta, fecha, hora);
    }

    public ArrayList<Entidades.Venta> verificarVencimientos() throws SQLException, ClassNotFoundException {
        return ventaDatos.verificarVencimientos();
    }

    public ArrayList<Entidades.Venta> getAllVentas(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        return ventaDatos.getAllVentas(sortname, sortorder, search);
    }
    public void eliminarVenta(long idVenta) throws SQLException, Exception {
        ventaDatos.eliminarVenta(idVenta);
    }
    public String ventaMensualActual() throws SQLException, ClassNotFoundException, Exception {
        return ventaDatos.ventaMensualActual();
    }
}

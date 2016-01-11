/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.LineaDeCompra;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Hamal
 */
public class CatalogoDeCompras {

    Datos.Compra compraDatos = new Datos.Compra();

    public void guardarCompra(long dniUsuario, long idProveedor, long idCompra, String nroRemito, String nroFactura, double precioTotalCompraCalculado, Date fechaHoy, Time horaHoy, double precioTotalRemito) throws ParseException, Exception {
        Entidades.Compra compra = new Entidades.Compra();

        compra.setIdCompra(idCompra);
        compra.setNroFacturaCompra(nroFactura);
        compra.setNroRemitoCompra(nroRemito);
        compra.setPrecioTotalCompraCalculado(precioTotalCompraCalculado);
        compra.setFechaEntregaCompra(fechaHoy);
        compra.setFechaCompra(fechaHoy);
        Calendar c = Calendar.getInstance();
        c.setTime(fechaHoy);
        c.add(Calendar.DATE, 7);
        java.sql.Date fechaVencimiento = new java.sql.Date(c.getTimeInMillis());
        compra.setFechaVencimientoCompra(fechaVencimiento);
        //setiar fecha 
        compra.setHoraEntregaCompra(horaHoy);
        compra.setPrecioTotalCompra(precioTotalRemito);
        //setiar vencimiento
        compra.setDniUsuario(dniUsuario);
        compra.setCuitProveedor(idProveedor);
        compra.setEstadoCompra("Entregado");
        // ir a la base de datos a guardar
        compraDatos.guardarCompra(compra);
    }

    public void actualizarEstadoCompra(Entidades.Pago pago, ArrayList<Entidades.Pago> pagosRealizados) throws SQLException, ClassNotFoundException, Exception {
        long idCompra = pago.getIdTransaccion();
        Datos.Proveedor proveedorDatos = new Datos.Proveedor();
        double precioTotalCompra = compraDatos.obtenerPrecioCompra(idCompra);
        //double precioTotalCompra=compraDatos.obtenerPrecioCompra(idCompra);
        double totalPagos = 0;
        for (Entidades.Pago pagoRealizado : pagosRealizados) {
            totalPagos = totalPagos + pagoRealizado.getMontoPago();
        }
        double resto = precioTotalCompra - totalPagos;
        String estado = "";
        if (resto > 0) {
            estado = "Pago Parcial";
        }
        if (resto <= 0) {
            estado = "Pagado";

        }
        //lo cambie de esta forma para que siempre se setea fechaUPago y horaUPago
        Date fecha = pago.getFechaPago();
        Time hora = pago.getHoraPago();
        compraDatos.setEstadoPagada(estado, idCompra, fecha, hora);
        proveedorDatos.actualizoCtaCte(pago.getMontoPago(), pago.getIdTransaccion());
        //return resto;
    }

    public ArrayList<Entidades.Compra> getAllCompras(String sortname, String sortorder, String search) throws Exception {
        return compraDatos.getAllCompras(sortname, sortorder, search);
    }
    public void eliminarCompra(long idCompra) throws SQLException, Exception {
        compraDatos.eliminarCompra(idCompra);
    }
     public ArrayList<Entidades.Compra> verificarVencimientos() throws Exception {
        return compraDatos.verificarVencimientos();
    }
     
      public String compraMensualActual() throws SQLException, ClassNotFoundException, Exception {
          return compraDatos.compraMensualActual();
      }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.Pago;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hamal
 */
public class CatalogoDePagos {

    Datos.Pago pagoDatos = new Datos.Pago();

    public void guardarPago(Entidades.Pago pago) throws Exception {
        pagoDatos.guardarPago(pago);
    }

    public ArrayList<Entidades.Pago> getAllPagos(String sortname, String sortorder, String search, long idTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        return pagoDatos.getAllPagos(sortname, sortorder, search, idTransaccion);
    }

    public ArrayList<Entidades.Pago> getAllPagosTipo(String sortname, String sortorder, String search, String tipoTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        return pagoDatos.getAllPagosTipo(sortname, sortorder, search, tipoTransaccion);
    }

    void eliminarPago(long idPago, Date fechaPago, Time horaPago) throws Exception {

        List<Entidades.Pago> listPagos = this.getAllPagos("idTransaccion", "asc", "", idPago);
        pagoDatos.eliminarPago(idPago, fechaPago, horaPago);

        if (listPagos.get(0).getTipoTransaccion().equals("venta")) {
            Datos.venta ventaDatos = new Datos.venta();
            Entidades.Venta venta = ventaDatos.getOne(listPagos.get(0).getIdTransaccion());
            if (listPagos.size() - 1 == 0) {
                if (venta.getFechaEntregaVenta() != null) {
                    ventaDatos.setEstadoParcial("Entregado", venta.getIdVenta());
                } else {
                    ventaDatos.setEstadoParcial("Registrado", venta.getIdVenta());
                }
            } else {
                ventaDatos.setEstadoParcial("Pago Parcial", venta.getIdVenta());
            }
        } else {
            Datos.Compra compraDatos = new Datos.Compra();
            if (listPagos.size() - 1 == 0) {
                compraDatos.setEstadoParcial("Entregado", idPago);
            } else {
                compraDatos.setEstadoParcial("Pago Parcial", idPago);
            }
        }
    }
}

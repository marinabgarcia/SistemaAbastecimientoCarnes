/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.Pago;
import java.sql.SQLException;
import java.util.ArrayList;

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
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Marina
 */
public class CatalogoDePreciosCompra {

    Datos.PrecioCompra preciosDatos = new Datos.PrecioCompra();

    public void altaPrecioCompra(Entidades.PreciosCompra precioCompraNuevo) throws Exception {
        preciosDatos.altaPrecioCompra(precioCompraNuevo);
    }

    public int modificarPrecioCompra(Entidades.PreciosCompra precioCompra) throws Exception {
        return preciosDatos.modificarPrecioCompra(precioCompra);
    }

    public Entidades.PreciosCompra getOnePrecioCompra(int idArticulo, long cuitProveedor) throws Exception {
        return preciosDatos.getOne(idArticulo, cuitProveedor);
    }

    public ArrayList<Entidades.PreciosCompra> getAllPreciosCVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        return preciosDatos.getAllPreciosCVigentes(idArticulo);
    }

}

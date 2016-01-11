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
 * @author Marina
 */
public class CatalogoDeProveedores {
    Datos.Proveedor proveedorDatos =new Datos.Proveedor();
    public void altaDeProveedor(Entidades.Proveedor proveedoNuevo) throws Exception {
        proveedorDatos.altaProveedor(proveedoNuevo);
    }
     int modificacionDeProveedor(Entidades.Proveedor proveedoModificado) throws Exception {
        return proveedorDatos.modificarProveedor(proveedoModificado);
    }
     int bajaDeProveedor(Long cuit) throws Exception {
       return proveedorDatos.eliminarProveedor(cuit);
    }
     public int activarProveedor(Long cuit) throws Exception {
        return proveedorDatos.activarProveedor(cuit);
    }

    public ArrayList<Entidades.Proveedor> getTotalProveedores(String query, String filtro) throws Exception {
        return proveedorDatos.getTotalProveedores(query, filtro);
    }

    public ArrayList<Entidades.Proveedor> getProveedores(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return proveedorDatos.getProveedores(page, rp, sortname, sortorder, query, filtro);
    }
    public ArrayList<Entidades.Proveedor> getProveedoresB(String sortname, String sortorder, String query) throws Exception {
        return proveedorDatos.getProveedoresB(sortname, sortorder, query);
    }
    public ArrayList<Entidades.Proveedor> getAllProveedores() throws Exception {
        return proveedorDatos.getAllProveedores();
    }

    public void actualizarCtaCte(Entidades.Pago pago) {
        long idCompra=pago.getIdTransaccion();
/*       double ctacte= proveedorDatos.obtenerCtaCte(idCompra);
       double ccn=ctacte+pago.getMontoPago();
       proveedorDatos.actualizoCtaCte(ccn,idCompra);*/
    }
    public int obtenerCantidadProveedores() throws SQLException, ClassNotFoundException {
        return proveedorDatos.obtenerCantidadProveedores();
    }
}

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
public class CatalogoDeClientes {
    Datos.Cliente clienteDatos =new Datos.Cliente();
    public void altaDeCliente(Entidades.Cliente clienteNuevo) throws Exception {
     clienteDatos.altaCliente(clienteNuevo);
    }
     int modificacionDeCliente(Entidades.Cliente clienteModificado) throws Exception {
        return clienteDatos.modificarCliente(clienteModificado);
    }
     int bajaDeCliente(Long dni) throws Exception {
       return clienteDatos.eliminarCliente(dni);
    }
    public int activarCliente(Long dni) throws Exception {
        return clienteDatos.activarCliente(dni);
    }

    public ArrayList<Entidades.Cliente> getTotalClientes(String query, String filtro) throws Exception {
        return clienteDatos.getTotalClientes(query, filtro);
    }

    public ArrayList<Entidades.Cliente> getClientes(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return clienteDatos.getClientes(page, rp, sortname, sortorder, query, filtro);
    }
    public ArrayList<Entidades.Cliente> getClientesB(String sortname, String sortorder, String search) throws Exception {
        return clienteDatos.getClientesB(sortname, sortorder, search);
    }

    long devolverTipoCliente(long idCliente) throws SQLException, ClassNotFoundException, Exception {
        return clienteDatos.devolverTipoCliente(idCliente);
    }
    public int obtenerCantidadClientes() throws SQLException, ClassNotFoundException {
        return clienteDatos.obtenerCantidadClientes();
    }
    
    public Entidades.Cliente getOneCliente(Long dni) throws Exception{
        return clienteDatos.getOne(dni);
    }
}

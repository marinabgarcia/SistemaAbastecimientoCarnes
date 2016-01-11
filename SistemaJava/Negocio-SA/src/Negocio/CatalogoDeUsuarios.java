/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Negocio;

import Entidades.Usuario;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Hamal
 */
public class CatalogoDeUsuarios {
   Datos.Usuario usuarioDatos= new Datos.Usuario();
      public Entidades.Usuario buscarUsuario(long usuario, String contraseña) throws SQLException, 
            ClassNotFoundException, Exception {

        Entidades.Usuario us;
        us = usuarioDatos.validarUsuario(contraseña, usuario);
        return us;
          }

   public void altaDeUsuario(Entidades.Usuario usuarioNuevo) throws Exception {
        usuarioDatos.altaUsuario(usuarioNuevo);
            

    }

   public int modificacionDeUsuario(Entidades.Usuario usuarioModificado) throws Exception {
        return usuarioDatos.modificarCliente(usuarioModificado);
    }

   public int bajaDeUsuario(Long dni,Date fb) throws Exception {
       return usuarioDatos.eliminarUsuario(dni, (java.sql.Date) fb);
    }

    public int activarUsuario(Long dni) throws Exception {
        return usuarioDatos.activarUsuario(dni);
    }

    public ArrayList<Entidades.Usuario> getTotalUsuarios(String query, String filtro) throws Exception {
         return usuarioDatos.getTotalUsuarios(query, filtro);
    }

    ArrayList<Usuario> getUsuarios(int page, int rp, String sortname, String sortorder, String query, String filtro) throws Exception {
        return usuarioDatos.getUsuarios(page, rp, sortname, sortorder, query, filtro);
    }
    ArrayList<Usuario> getUsuariosB(String sortname, String sortorder, String query) throws Exception {
        return usuarioDatos.getUsuariosB(sortname, sortorder, query);
    }
    
}

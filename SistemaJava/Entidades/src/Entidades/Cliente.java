/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

/**
 *
 * @author Marina
 */
public class Cliente {

    private long dniCliente;
    private long cuitCliente;
    private String nombreCliente;
    private String apellidoCliente;
    private String direccionCliente;
    private int localidadCliente;
    private String telefonoCliente;
    private int provinciaCliente;
    private String celularCliente;
    private String emailCliente;
    private String razonSocialCliente;
    private double cuentaCorrienteCliente;
    private String estadoCliente;
    private int idTipoCliente;
    //descripcion de provincia y localidad para la tabla de interfaz
    private String dLocalidad;
    private String dProvincia;
    private String dTipoCliente;

    /**
     * @return the cuilCliente
     */
    public long getCuitCliente() {
        return cuitCliente;
    }

    /**
     * @param cuilCliente the cuilCliente to set
     */
    public void setCuitCliente(long cuilCliente) {
        this.cuitCliente = cuilCliente;
    }

    /**
     * @return the nombreCliente
     */
    public String getNombreCliente() {
        return nombreCliente;
    }

    /**
     * @param nombreCliente the nombreCliente to set
     */
    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    /**
     * @return the apellidoCliente
     */
    public String getApellidoCliente() {
        return apellidoCliente;
    }

    /**
     * @param apellidoCliente the apellidoCliente to set
     */
    public void setApellidoCliente(String apellidoCliente) {
        this.apellidoCliente = apellidoCliente;
    }

    /**
     * @return the direccionCliente
     */
    public String getDireccionCliente() {
        return direccionCliente;
    }

    /**
     * @param direccionCliente the direccionCliente to set
     */
    public void setDireccionCliente(String direccionCliente) {
        this.direccionCliente = direccionCliente;
    }

    /**
     * @return the emailCliente
     */
    public String getEmailCliente() {
        return emailCliente;
    }

    /**
     * @param emailCliente the emailCliente to set
     */
    public void setEmailCliente(String emailCliente) {
        this.emailCliente = emailCliente;
    }

    /**
     * @return the razonSocialCliente
     */
    public String getRazonSocialCliente() {
        return razonSocialCliente;
    }

    /**
     * @param razonSocialCliente the razonSocialCliente to set
     */
    public void setRazonSocialCliente(String razonSocialCliente) {
        this.razonSocialCliente = razonSocialCliente;
    }

    /**
     * @return the cuentaCorrienteCliente
     */
    public double getCuentaCorrienteCliente() {
        return cuentaCorrienteCliente;
    }

    /**
     * @param cuentaCorrienteCliente the cuentaCorrienteCliente to set
     */
    public void setCuentaCorrienteCliente(double cuentaCorrienteCliente) {
        this.cuentaCorrienteCliente = cuentaCorrienteCliente;
    }

    /**
     * @return the estadoCliente
     */
    public String getEstadoCliente() {
        return estadoCliente;
    }

    /**
     * @param estadoCliente the estadoCliente to set
     */
    public void setEstadoCliente(String estadoCliente) {
        this.estadoCliente = estadoCliente;
    }

    /**
     * @return the localidadCliente
     */
    public int getLocalidadCliente() {
        return localidadCliente;
    }

    /**
     * @param localidadCliente the localidadCliente to set
     */
    public void setLocalidadCliente(int localidadCliente) {
        this.localidadCliente = localidadCliente;
    }

    /**
     * @return the telefonoCliente
     */
    public String getTelefonoCliente() {
        return telefonoCliente;
    }

    /**
     * @param telefonoCliente the telefonoCliente to set
     */
    public void setTelefonoCliente(String telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

    /**
     * @return the provinciaCliente
     */
    public int getProvinciaCliente() {
        return provinciaCliente;
    }

    /**
     * @param provinciaCliente the provinciaCliente to set
     */
    public void setProvinciaCliente(int provinciaCliente) {
        this.provinciaCliente = provinciaCliente;
    }

    /**
     * @return the celularCliente
     */
    public String getCelularCliente() {
        return celularCliente;
    }

    /**
     * @param celularCliente the celularCliente to set
     */
    public void setCelularCliente(String celularCliente) {
        this.celularCliente = celularCliente;
    }

    /**
     * @return the idTipoCliente
     */
    public int getIdTipoCliente() {
        return idTipoCliente;
    }

    /**
     * @param idTipoCliente the idTipoCliente to set
     */
    public void setIdTipoCliente(int idTipoCliente) {
        this.idTipoCliente = idTipoCliente;
    }

    /**
     * @return the dniCliente
     */
    public long getDniCliente() {
        return dniCliente;
    }

    /**
     * @param dniCliente the dniCliente to set
     */
    public void setDniCliente(long dniCliente) {
        this.dniCliente = dniCliente;
    }

    /**
     * @return the dLocalidad
     */
    public String getdLocalidad() {
        return dLocalidad;
    }

    /**
     * @param dLocalidad the dLocalidad to set
     */
    public void setdLocalidad(String dLocalidad) {
        this.dLocalidad = dLocalidad;
    }

    /**
     * @return the dProvincia
     */
    public String getdProvincia() {
        return dProvincia;
    }

    /**
     * @param dProvincia the dProvincia to set
     */
    public void setdProvincia(String dProvincia) {
        this.dProvincia = dProvincia;
    }

    /**
     * @return the dTipoCliente
     */
    public String getdTipoCliente() {
        return dTipoCliente;
    }

    /**
     * @param dTipoCliente the dTipoCliente to set
     */
    public void setdTipoCliente(String dTipoCliente) {
        this.dTipoCliente = dTipoCliente;
    }

}

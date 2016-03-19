/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

import java.sql.Time;
import java.sql.Date;

/**
 *
 * @author Hamal
 */
public class Pago {
    private long idTransaccion;
    private String idTransaccionS;
    private String tipoTransaccion;
    private String formaDePago;
    private double montoPago;
    private Date fechaPago;
    private String fechaPagoS;
    private Time horaPago;
    private String horaPagoS;
    private String nroCheque;
    private String nombreCheque;
    private String bancoCheque;
    private long dniUsuario;
    //mostrar pagos en tabla
    private String nombre;
    private String dni;
    private String cuit;
    private String razonSocial;
    private String id;
    private String telefono;
    private String celular;
    private String idCP;

    /**
     * @return the idTransaccion
     */
    public long getIdTransaccion() {
        return idTransaccion;
    }

    /**
     * @param idTransaccion the idTransaccion to set
     */
    public void setIdTransaccion(long idTransaccion) {
        this.idTransaccion = idTransaccion;
    }

    /**
     * @return the tipoTransaccion
     */
    public String getTipoTransaccion() {
        return tipoTransaccion;
    }

    /**
     * @param tipoTransaccion the tipoTransaccion to set
     */
    public void setTipoTransaccion(String tipoTransaccion) {
        this.tipoTransaccion = tipoTransaccion;
    }

    /**
     * @return the formaDePago
     */
    public String getFormaDePago() {
        return formaDePago;
    }

    /**
     * @param formaDePago the formaDePago to set
     */
    public void setFormaDePago(String formaDePago) {
        this.formaDePago = formaDePago;
    }

    /**
     * @return the montoPago
     */
    public double getMontoPago() {
        return montoPago;
    }

    /**
     * @param montoPago the montoPago to set
     */
    public void setMontoPago(double montoPago) {
        this.montoPago = montoPago;
    }

    /**
     * @return the fechaPago
     */
    public Date getFechaPago() {
        return fechaPago;
    }

    /**
     * @param fechaPago the fechaPago to set
     */
    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }

    /**
     * @return the horaPago
     */
    public Time getHoraPago() {
        return horaPago;
    }

    /**
     * @param horaPago the horaPago to set
     */
    public void setHoraPago(Time horaPago) {
        this.horaPago = horaPago;
    }

    /**
     * @return the nroCheque
     */
    public String getNroCheque() {
        return nroCheque;
    }

    /**
     * @param nroCheque the nroCheque to set
     */
    public void setNroCheque(String nroCheque) {
        this.nroCheque = nroCheque;
    }

    /**
     * @return the nombreCheque
     */
    public String getNombreCheque() {
        return nombreCheque;
    }

    /**
     * @param nombreCheque the nombreCheque to set
     */
    public void setNombreCheque(String nombreCheque) {
        this.nombreCheque = nombreCheque;
    }

    /**
     * @return the bancoCheque
     */
    public String getBancoCheque() {
        return bancoCheque;
    }

    /**
     * @param bancoCheque the bancoCheque to set
     */
    public void setBancoCheque(String bancoCheque) {
        this.bancoCheque = bancoCheque;
    }

    /**
     * @return the dniUsuario
     */
    public long getDniUsuario() {
        return dniUsuario;
    }

    /**
     * @param dniUsuario the dniUsuario to set
     */
    public void setDniUsuario(long dniUsuario) {
        this.dniUsuario = dniUsuario;
    }

    /**
     * @return the fechaPagoS
     */
    public String getFechaPagoS() {
        return fechaPagoS;
    }

    /**
     * @param fechaPagoS the fechaPagoS to set
     */
    public void setFechaPagoS(String fechaPagoS) {
        this.fechaPagoS = fechaPagoS;
    }

    /**
     * @return the horaPagoS
     */
    public String getHoraPagoS() {
        return horaPagoS;
    }

    /**
     * @param horaPagoS the horaPagoS to set
     */
    public void setHoraPagoS(String horaPagoS) {
        this.horaPagoS = horaPagoS;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the dni
     */
    public String getDni() {
        return dni;
    }

    /**
     * @param dni the dni to set
     */
    public void setDni(String dni) {
        this.dni = dni;
    }

    /**
     * @return the cuit
     */
    public String getCuit() {
        return cuit;
    }

    /**
     * @param cuit the cuit to set
     */
    public void setCuit(String cuit) {
        this.cuit = cuit;
    }

    /**
     * @return the razonSocial
     */
    public String getRazonSocial() {
        return razonSocial;
    }

    /**
     * @param razonSocial the razonSocial to set
     */
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the telefono
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * @param telefono the telefono to set
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * @return the celular
     */
    public String getCelular() {
        return celular;
    }

    /**
     * @param celular the celular to set
     */
    public void setCelular(String celular) {
        this.celular = celular;
    }

    /**
     * @return the idTransaccionS
     */
    public String getIdTransaccionS() {
        return idTransaccionS;
    }

    /**
     * @param idTransaccionS the idTransaccionS to set
     */
    public void setIdTransaccionS(String idTransaccionS) {
        this.idTransaccionS = idTransaccionS;
    }

    /**
     * @return the idCP
     */
    public String getIdCP() {
        return idCP;
    }

    /**
     * @param idCP the idCP to set
     */
    public void setIdCP(String idCP) {
        this.idCP = idCP;
    }
    
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

import java.sql.Time;
import java.util.Date;

/**
 *
 * @author Hamal
 */
public class Venta {
    private long idVenta;
    private String idVentaS;
    private Date fechaVenta;
    private String fechaVentaS;
    private Time horaVenta;
    private String horaVentaS;
    private Date fechaEntregaVenta;
    private String fechaEntregaVentaS;
    private Time horaEntregaVenta;
    private String horaEntregaVentaS;
    private Date fechaUCobroVenta;
    private String fechaUCobroVentaS;
    private Time horaUCobroVenta;
    private String horaUCobroVentaS;
    private Date fechaVencimiento;
    private String fechaVencimientoVentaS;
    private String estadoVenta;
    private double precioTotalVenta;
    private String nroRemitoVenta;
    private String nroFacturaVenta;
    private long dniCliente;
    private long cuitCliente;
    private long dniUsuario;
    private String cliente;
    private String razonSocialCliente;

    /**
     * @return the idVenta
     */
    public long getIdVenta() {
        return idVenta;
    }

    /**
     * @param idVenta the idVenta to set
     */
    public void setIdVenta(long idVenta) {
        this.idVenta = idVenta;
    }

    /**
     * @return the fechaVenta
     */
    public Date getFechaVenta() {
        return fechaVenta;
    }

    /**
     * @param fechaVenta the fechaVenta to set
     */
    public void setFechaVenta(Date fechaVenta) {
        this.fechaVenta = fechaVenta;
    }

    /**
     * @return the horaVenta
     */
    public Time getHoraVenta() {
        return horaVenta;
    }

    /**
     * @param horaVenta the horaVenta to set
     */
    public void setHoraVenta(Time horaVenta) {
        this.horaVenta = horaVenta;
    }

    /**
     * @return the fechaEntregaVenta
     */
    public Date getFechaEntregaVenta() {
        return fechaEntregaVenta;
    }

    /**
     * @param fechaEntregaVenta the fechaEntregaVenta to set
     */
    public void setFechaEntregaVenta(Date fechaEntregaVenta) {
        this.fechaEntregaVenta = fechaEntregaVenta;
    }

    /**
     * @return the horaEntregaVenta
     */
    public Time getHoraEntregaVenta() {
        return horaEntregaVenta;
    }

    /**
     * @param horaEntregaVenta the horaEntregaVenta to set
     */
    public void setHoraEntregaVenta(Time horaEntregaVenta) {
        this.horaEntregaVenta = horaEntregaVenta;
    }

    /**
     * @return the fechaUCobroVenta
     */
    public Date getFechaUCobroVenta() {
        return fechaUCobroVenta;
    }

    /**
     * @param fechaUCobroVenta the fechaUCobroVenta to set
     */
    public void setFechaUCobroVenta(Date fechaUCobroVenta) {
        this.fechaUCobroVenta = fechaUCobroVenta;
    }

    /**
     * @return the horaUCobroVenta
     */
    public Time getHoraUCobroVenta() {
        return horaUCobroVenta;
    }

    /**
     * @param horaUCobroVenta the horaUCobroVenta to set
     */
    public void setHoraUCobroVenta(Time horaUCobroVenta) {
        this.horaUCobroVenta = horaUCobroVenta;
    }

    /**
     * @return the fechaVencimiento
     */
    public Date getFechaVencimiento() {
        return fechaVencimiento;
    }

    /**
     * @param fechaVencimiento the fechaVencimiento to set
     */
    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    /**
     * @return the estadoVenta
     */
    public String getEstadoVenta() {
        return estadoVenta;
    }

    /**
     * @param estadoVenta the estadoVenta to set
     */
    public void setEstadoVenta(String estadoVenta) {
        this.estadoVenta = estadoVenta;
    }

    /**
     * @return the precioTotalVenta
     */
    public double getPrecioTotalVenta() {
        return precioTotalVenta;
    }

    /**
     * @param precioTotalVenta the precioTotalVenta to set
     */
    public void setPrecioTotalVenta(double precioTotalVenta) {
        this.precioTotalVenta = precioTotalVenta;
    }

    /**
     * @return the nroRemitoVenta
     */
    public String getNroRemitoVenta() {
        return nroRemitoVenta;
    }

    /**
     * @param nroRemitoVenta the nroRemitoVenta to set
     */
    public void setNroRemitoVenta(String nroRemitoVenta) {
        this.nroRemitoVenta = nroRemitoVenta;
    }

    /**
     * @return the nroFacturaVenta
     */
    public String getNroFacturaVenta() {
        return nroFacturaVenta;
    }

    /**
     * @param nroFacturaVenta the nroFacturaVenta to set
     */
    public void setNroFacturaVenta(String nroFacturaVenta) {
        this.nroFacturaVenta = nroFacturaVenta;
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
     * @return the fechaVentaS
     */
    public String getFechaVentaS() {
        return fechaVentaS;
    }

    /**
     * @param fechaVentaS the fechaVentaS to set
     */
    public void setFechaVentaS(String fechaVentaS) {
        this.fechaVentaS = fechaVentaS;
    }

    /**
     * @return the horaVentaS
     */
    public String getHoraVentaS() {
        return horaVentaS;
    }

    /**
     * @param horaVentaS the horaVentaS to set
     */
    public void setHoraVentaS(String horaVentaS) {
        this.horaVentaS = horaVentaS;
    }

    /**
     * @return the fechaEntregaVentaS
     */
    public String getFechaEntregaVentaS() {
        return fechaEntregaVentaS;
    }

    /**
     * @param fechaEntregaVentaS the fechaEntregaVentaS to set
     */
    public void setFechaEntregaVentaS(String fechaEntregaVentaS) {
        this.fechaEntregaVentaS = fechaEntregaVentaS;
    }

    /**
     * @return the horaEntregaVentaS
     */
    public String getHoraEntregaVentaS() {
        return horaEntregaVentaS;
    }

    /**
     * @param horaEntregaVentaS the horaEntregaVentaS to set
     */
    public void setHoraEntregaVentaS(String horaEntregaVentaS) {
        this.horaEntregaVentaS = horaEntregaVentaS;
    }

    /**
     * @return the fechaUCobroVentaS
     */
    public String getFechaUCobroVentaS() {
        return fechaUCobroVentaS;
    }

    /**
     * @param fechaUCobroVentaS the fechaUCobroVentaS to set
     */
    public void setFechaUCobroVentaS(String fechaUCobroVentaS) {
        this.fechaUCobroVentaS = fechaUCobroVentaS;
    }

    /**
     * @return the horaUCobroVentaS
     */
    public String getHoraUCobroVentaS() {
        return horaUCobroVentaS;
    }

    /**
     * @param horaUCobroVentaS the horaUCobroVentaS to set
     */
    public void setHoraUCobroVentaS(String horaUCobroVentaS) {
        this.horaUCobroVentaS = horaUCobroVentaS;
    }

    /**
     * @return the fechaVencimientoS
     */
    public String getFechaVencimientoS() {
        return getFechaVencimientoVentaS();
    }

    /**
     * @param fechaVencimientoS the fechaVencimientoS to set
     */
    public void setFechaVencimientoS(String fechaVencimientoS) {
        this.setFechaVencimientoVentaS(fechaVencimientoS);
    }

    /**
     * @return the cuitCliente
     */
    public long getCuitCliente() {
        return cuitCliente;
    }

    /**
     * @param cuitCliente the cuitCliente to set
     */
    public void setCuitCliente(long cuitCliente) {
        this.cuitCliente = cuitCliente;
    }

    /**
     * @return the fechaVencimientoVentaS
     */
    public String getFechaVencimientoVentaS() {
        return fechaVencimientoVentaS;
    }

    /**
     * @param fechaVencimientoVentaS the fechaVencimientoVentaS to set
     */
    public void setFechaVencimientoVentaS(String fechaVencimientoVentaS) {
        this.fechaVencimientoVentaS = fechaVencimientoVentaS;
    }

    /**
     * @return the cliente
     */
    public String getCliente() {
        return cliente;
    }

    /**
     * @param cliente the cliente to set
     */
    public void setCliente(String cliente) {
        this.cliente = cliente;
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
     * @return the idVentaS
     */
    public String getIdVentaS() {
        return idVentaS;
    }

    /**
     * @param idVentaS the idVentaS to set
     */
    public void setIdVentaS(String idVentaS) {
        this.idVentaS = idVentaS;
    }
}
 
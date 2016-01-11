/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

/**
 *
 * @author Hamal
 */
public class LineaDeVenta {
    private long idLineaVenta;
  private int cantidadLineaVenta;
  private String observacionLineaVenta;
  private double precioLineaVenta;
  private double pesoLineaVenta;
  private int idArticulo;
  private long idVenta;
  private String idLineaVentaS;
  private double precioVenta;
  private String descripcionArticulo;
  private String descripcionCalidad;

    /**
     * @return the idLineaVenta
     */
    public long getIdLineaVenta() {
        return idLineaVenta;
    }

    /**
     * @param idLineaVenta the idLineaVenta to set
     */
    public void setIdLineaVenta(long idLineaVenta) {
        this.idLineaVenta = idLineaVenta;
    }

    /**
     * @return the cantidadLineaVenta
     */
    public int getCantidadLineaVenta() {
        return cantidadLineaVenta;
    }

    /**
     * @param cantidadLineaVenta the cantidadLineaVenta to set
     */
    public void setCantidadLineaVenta(int cantidadLineaVenta) {
        this.cantidadLineaVenta = cantidadLineaVenta;
    }

    /**
     * @return the observacionLineaVenta
     */
    public String getObservacionLineaVenta() {
        return observacionLineaVenta;
    }

    /**
     * @param observacionLineaVenta the observacionLineaVenta to set
     */
    public void setObservacionLineaVenta(String observacionLineaVenta) {
        this.observacionLineaVenta = observacionLineaVenta;
    }

    /**
     * @return the precioLineaVenta
     */
    public double getPrecioLineaVenta() {
        return precioLineaVenta;
    }

    /**
     * @param precioLineaVenta the precioLineaVenta to set
     */
    public void setPrecioLineaVenta(double precioLineaVenta) {
        this.precioLineaVenta = precioLineaVenta;
    }

    /**
     * @return the pesoLineaVenta
     */
    public double getPesoLineaVenta() {
        return pesoLineaVenta;
    }

    /**
     * @param pesoLineaVenta the pesoLineaVenta to set
     */
    public void setPesoLineaVenta(double pesoLineaVenta) {
        this.pesoLineaVenta = pesoLineaVenta;
    }

    /**
     * @return the idArticulo
     */
    public int getIdArticulo() {
        return idArticulo;
    }

    /**
     * @param idArticulo the idArticulo to set
     */
    public void setIdArticulo(int idArticulo) {
        this.idArticulo = idArticulo;
    }

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
     * @return the idLineaVentaS
     */
    public String getIdLineaVentaS() {
        return idLineaVentaS;
    }

    /**
     * @param idLineaVentaS the idLineaVentaS to set
     */
    public void setIdLineaVentaS(String idLineaVentaS) {
        this.idLineaVentaS = idLineaVentaS;
    }

    /**
     * @return the precioVenta
     */
    public double getPrecioVenta() {
        return precioVenta;
    }

    /**
     * @param precioVenta the precioVenta to set
     */
    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }

    /**
     * @return the descripcionArticulo
     */
    public String getDescripcionArticulo() {
        return descripcionArticulo;
    }

    /**
     * @param descripcionArticulo the descripcionArticulo to set
     */
    public void setDescripcionArticulo(String descripcionArticulo) {
        this.descripcionArticulo = descripcionArticulo;
    }

    /**
     * @return the descripcionCalidad
     */
    public String getDescripcionCalidad() {
        return descripcionCalidad;
    }

    /**
     * @param descripcionCalidad the descripcionCalidad to set
     */
    public void setDescripcionCalidad(String descripcionCalidad) {
        this.descripcionCalidad = descripcionCalidad;
    }
}

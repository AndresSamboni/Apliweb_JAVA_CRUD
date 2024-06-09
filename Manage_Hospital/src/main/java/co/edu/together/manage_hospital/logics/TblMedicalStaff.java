/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.together.manage_hospital.logics;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Edwin Andrés Samboní Ortiz
 */

// TABLE DEFINITION
@Entity
@Table(name = "tbl_medical_staff")

// QUERIES DEFINITION
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblMedicalStaff.findAll", query = "SELECT t FROM TblMedicalStaff t"),
    @NamedQuery(name = "TblMedicalStaff.findByIdMedicalStaff", query = "SELECT t FROM TblMedicalStaff t WHERE t.idMedicalStaff = :idMedicalStaff"),
    @NamedQuery(name = "TblMedicalStaff.findByName", query = "SELECT t FROM TblMedicalStaff t WHERE t.name = :name"),
    @NamedQuery(name = "TblMedicalStaff.findByLastName", query = "SELECT t FROM TblMedicalStaff t WHERE t.lastName = :lastName"),
    @NamedQuery(name = "TblMedicalStaff.findBySex", query = "SELECT t FROM TblMedicalStaff t WHERE t.sex = :sex"),
    @NamedQuery(name = "TblMedicalStaff.findByBirthdate", query = "SELECT t FROM TblMedicalStaff t WHERE t.birthdate = :birthdate"),
    @NamedQuery(name = "TblMedicalStaff.findByAddress", query = "SELECT t FROM TblMedicalStaff t WHERE t.address = :address"),
    @NamedQuery(name = "TblMedicalStaff.findByPhone", query = "SELECT t FROM TblMedicalStaff t WHERE t.phone = :phone"),
    @NamedQuery(name = "TblMedicalStaff.findByEmail", query = "SELECT t FROM TblMedicalStaff t WHERE t.email = :email"),
    @NamedQuery(name = "TblMedicalStaff.findByRethus", query = "SELECT t FROM TblMedicalStaff t WHERE t.rethus = :rethus"),
    @NamedQuery(name = "TblMedicalStaff.findByContractStartDate", query = "SELECT t FROM TblMedicalStaff t WHERE t.contractStartDate = :contractStartDate"),
    @NamedQuery(name = "TblMedicalStaff.findByContractEndDate", query = "SELECT t FROM TblMedicalStaff t WHERE t.contractEndDate = :contractEndDate")
})

// CLASS THAT REPRESENT THE ENTITY
public class TblMedicalStaff implements Serializable {

    private static final long serialVersionUID = 1L;
    
    // IDENTIFIER OF THE MEDICAL STAFF
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_medical_staff")
    private Long idMedicalStaff;
    
    // NAME OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "name")
    private String name;
    
    // LAST NAME OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "last_name")
    private String lastName;
    
    // SEX OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Column(name = "sex")
    private Character sex;
    
    // BIRTHDATE OF THE MEDICAL STAFF
    @Column(name = "birthdate")
    @Temporal(TemporalType.DATE)
    private Date birthdate;
    
    // ADDRESS OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "address")
    private String address;
    
    // PHONE OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Column(name = "phone")
    private long phone;
    
    // EMAIL OF THE MEDICAL STAFF
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "email")
    private String email;
    
    // RETHUS OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Column(name = "rethus")
    private long rethus;
    
    // CONTRACT START DATE OF THE MEDICAL STAFF
    @Basic(optional = false)
    @NotNull
    @Column(name = "contract_start_date")
    @Temporal(TemporalType.DATE)
    private Date contractStartDate;
    
    // CONTRACT END DATE OF THE MEDICAL STAFF
    @Column(name = "contract_end_date")
    @Temporal(TemporalType.DATE)
    private Date contractEndDate;
    
    // ROLE IDENTIFIER THAT RELATES THE MEDICAL STAFF AND THE ROLE TABLES
    @JoinColumn(name = "id_role", referencedColumnName = "id_role")
    @ManyToOne(optional = false)
    private TblRole idRole;
    
    // SPECIALTY IDENTIFIER THAT RELATES THE MEDICAL STAFF AND THE ROLE TABLES
    @JoinColumn(name = "id_specialty", referencedColumnName = "id_specialty")
    @ManyToOne
    private TblSpecialty idSpecialty;

    // EMPTY CONSTRUCTOR
    public TblMedicalStaff() {
    }

    // CONSTRUCTOR BY ID
    public TblMedicalStaff(Long idMedicalStaff) {
        this.idMedicalStaff = idMedicalStaff;
    }

    // FULL CONSTRUCTOR
    public TblMedicalStaff(Long idMedicalStaff, String name, String lastName, Character sex, String address, long phone, String email, long rethus, Date contractStartDate) {
        this.idMedicalStaff = idMedicalStaff;
        this.name = name;
        this.lastName = lastName;
        this.sex = sex;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.rethus = rethus;
        this.contractStartDate = contractStartDate;
    }

    // GETTER AND SETTER METHODS
    public Long getIdMedicalStaff() {
        return idMedicalStaff;
    }

    public void setIdMedicalStaff(Long idMedicalStaff) {
        this.idMedicalStaff = idMedicalStaff;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Character getSex() {
        return sex;
    }

    public void setSex(Character sex) {
        this.sex = sex;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getPhone() {
        return phone;
    }

    public void setPhone(long phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getRethus() {
        return rethus;
    }

    public void setRethus(long rethus) {
        this.rethus = rethus;
    }

    public Date getContractStartDate() {
        return contractStartDate;
    }

    public void setContractStartDate(Date contractStartDate) {
        this.contractStartDate = contractStartDate;
    }

    public Date getContractEndDate() {
        return contractEndDate;
    }

    public void setContractEndDate(Date contractEndDate) {
        this.contractEndDate = contractEndDate;
    }

    public TblRole getIdRole() {
        return idRole;
    }

    public void setIdRole(TblRole idRole) {
        this.idRole = idRole;
    }

    public TblSpecialty getIdSpecialty() {
        return idSpecialty;
    }

    public void setIdSpecialty(TblSpecialty idSpecialty) {
        this.idSpecialty = idSpecialty;
    }

    // OTHER METHODS
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMedicalStaff != null ? idMedicalStaff.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TblMedicalStaff)) {
            return false;
        }
        TblMedicalStaff other = (TblMedicalStaff) object;
        if ((this.idMedicalStaff == null && other.idMedicalStaff != null) || (this.idMedicalStaff != null && !this.idMedicalStaff.equals(other.idMedicalStaff))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "co.edu.together.manage_hospital.logic.TblMedicalStaff[ idMedicalStaff=" + idMedicalStaff + " ]";
    }
    
}

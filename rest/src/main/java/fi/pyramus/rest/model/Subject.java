package fi.pyramus.rest.model;

public class Subject {

  public Subject() {
  }

  public Subject(Long id, String code, String name, Long educationTypeId, Boolean archived, Long version) {
    super();
    this.id = id;
    this.code = code;
    this.name = name;
    this.educationTypeId = educationTypeId;
    this.archived = archived;
    this.version = version;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Long getEducationTypeId() {
    return educationTypeId;
  }

  public void setEducationTypeId(Long educationTypeId) {
    this.educationTypeId = educationTypeId;
  }

  public Boolean getArchived() {
    return archived;
  }

  public void setArchived(Boolean archived) {
    this.archived = archived;
  }

  public Long getVersion() {
    return version;
  }

  public void setVersion(Long version) {
    this.version = version;
  }

  private Long id;
  private String code;
  private String name;
  private Long educationTypeId;
  private Boolean archived;
  private Long version;
}
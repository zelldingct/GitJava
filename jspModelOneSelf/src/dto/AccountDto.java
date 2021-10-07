package dto;

import java.io.Serializable;

public class AccountDto implements Serializable{

	private String id;
	private String pwd;
	private String name;
	private String email;
	private int aut;
	
	public AccountDto() {		
	}

	public AccountDto(String id, String pwd, String name, String email, int aut) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.aut = aut;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAut() {
		return aut;
	}

	public void setAut(int aut) {
		this.aut = aut;
	}

	@Override
	public String toString() {
		return "AccountDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", aut=" + aut + "]";
	}
	
	
}

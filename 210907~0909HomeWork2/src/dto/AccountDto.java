package dto;

public class AccountDto {
//변수설정
	private String date;
	private int cost;
	private String IncoExpe;
	private String title;
	private String content;
	
	public AccountDto() {
		
	}
//	construct
	public AccountDto(String date, int cost, String IncoExpe, String title, String content) {
		super();
		this.date = date;
		this.cost = cost;
		this.IncoExpe = IncoExpe;
		this.title = title;
		this.content = content;
	}
//	getter & setter
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public String getIncoExpe() {
		return IncoExpe;
	}
	public void setIncoExpe(String incoExpe) {
		IncoExpe = incoExpe;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	//toString
	@Override
	public String toString() {
		return "AccountDto [date=" + date + ", cost=" + cost + ", IncoExpe=" + IncoExpe + ", title=" + title
				+ ", content=" + content + "]";
	}
	
	
	
	
	
}

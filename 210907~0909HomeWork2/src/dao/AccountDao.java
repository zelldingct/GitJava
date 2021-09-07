package dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import dto.AccountDto;

public class AccountDao {
	
	Scanner sc = new Scanner(System.in);
		private List<AccountDto> list = new ArrayList<AccountDto>();
	
		public AccountDao() {
			list.add(new AccountDto("2021/09/08", 17000, "Expense", "저녁 식사", "친구와 치킨사먹음"));
			list.add(new AccountDto("2021/09/08", 300000, "Income", "알바비", "8월달 근로소득"));
			list.add(new AccountDto("2021/09/08", 1400, "Expense", "간식", "편의점 콜라"));
		}
		
			
		//추가
		public void Create() {
			System.out.print("날짜:");
			String date = sc.next();
			
			System.out.print("금액:");
			int cost = sc.nextInt();
			
			System.out.print("수입/비용");
			String IncoExpe = sc.next();
			
			System.out.print("제목:");
			String title = sc.next();
			
			System.out.print("내용:");
			String content = sc.next();
			
			list.add(new AccountDto(date,cost,IncoExpe,title,content));
			System.out.println("추가 되었습니다.");
		}
		//삭제
		public void Delete() {
			
			System.out.println("삭제할 제목을 입력:");
			String title = sc.next();
			
			int findIndex = search(title);
			if(findIndex == -1) {
				System.out.println("가계부 제목에 없는 항목입니다.");
			} else { 
				list.remove(findIndex);
				System.out.println("가계부 제목을 삭제합니다.");
			}
		}
		//검색
		public void Read() {
			System.out.println("검색할 제목을 입력:");
			String title = sc.next();
			
			int findIndex = search(title);
			
			if(findIndex == -1) {
				System.out.println("가계부 제목에 없는 항목입니다.");
			} else {
				AccountDto dto = list.get(findIndex);
				System.out.println(dto.toString());
			}
		}

		public void Update() {
			System.out.println("수정할 제목을 입력:");
			String title = sc.next();
			
			int findIndex = search(title);
			
			if(findIndex == -1) {
				System.out.println("가계부 제목에 없는 항목입니다.");
			} else {
				System.out.println("수정할 데이터를 입력해 주십시오.");
				
				System.out.print("날짜:");
				String date = sc.next();
				
				System.out.print("금액:");
				int cost = sc.nextInt();
				
				System.out.print("수입/비용");
				String IncoExpe = sc.next();
				
				System.out.print("내용");
				String content = sc.next();
				
				AccountDto dto = list.get(findIndex);
				dto.setDate(date);
				dto.setCost(cost);
				dto.setIncoExpe(IncoExpe);
				dto.setTitle(title);
				dto.setContent(content);
				
				System.out.println("가계부 데이터를 수정했습니다.");}
		}
		//search 함수 만들기
		public int search(String title) {
			int findIndex=-1;
			
			for (int i = 0; i < list.size(); i++) {
				AccountDto dto = list.get(i);
				
				if(title.equals(dto.getTitle())) {
					findIndex=i;
					break;
				}	
			}
			return findIndex;
		}
		public void allprint() {
			for (int i = 0; i < list.size(); i++) {
				AccountDto dto = list.get(i);
				System.out.println(dto.toString());
			}
		}
	
		
		
}
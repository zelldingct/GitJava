import dao.AccountDao;
import dto.AccountDto;
import java.util.Scanner;
public class accountBook {
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		AccountDao dao = new AccountDao();
		
		while(true) {
			System.out.println("0.오늘 날짜 확인");
			System.out.println("1.가계부 정보 추가");
			System.out.println("2.가계부 정보 삭제");
			System.out.println("3.가계부 정보 검색");
			System.out.println("4.가계부 정보 수정");
			System.out.println("5.가계부 정보 모두 출력");
			System.out.println("어느 작업을 하시겠습니까?");
			System.out.print(">>>>");
			
			int work = sc.nextInt();
			
			switch(work) {
			case 0:
				dao.Calendar();
				break;
			case 1:
				dao.Create();
				break;
			case 2:
				dao.Delete();
				break;
			case 3:
				dao.Read();
				break;
			case 4:
				dao.Update();
				break;
			case 5:
				dao.allprint();
				break;
			}
		}
	}

}

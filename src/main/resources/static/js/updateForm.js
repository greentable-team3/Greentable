//주소 검색 및 입력은 daum 주소 검색 API를 활용 여기서 검색하여 입력된 데이터 값(도로명 주소 + 상세 주소)은 js에서 하나의 데이터로 결합 
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
			// 우편번호와 주소 정보를 해당 필드에 넣음
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('roadAddress').value = data.roadAddress;
            // 커서를 상세주소 필드로 이동
            document.getElementById('detailAddress').focus();
        }
    }).open(); // 주소 검색 api 팝업창을 띄움
}
function checkpasswd(){
	let passwd = document.updateForm.m_passwd.value;
	let passwd2 = document.updateForm.m_passwd2.value;
	let msg = document.getElementById("pwMsg"); // 비밀번호 일치 불일치 표시
	
	// 아직 입력 안 된 상태면 아무 표시도 안 함
	if (!passwd || !passwd2) {
	    msg.textContent = "";
	       return false;
	}

	if (passwd !== passwd2) {
		msg.textContent = "비밀번호가 일치하지 않습니다.";
	    msg.style.color = "red";
	    return false;
	}

		msg.textContent = "비밀번호가 일치합니다.";
	    msg.style.color = "green";
	    return true;
}

function check() {
	let passwd = document.updateForm.m_passwd.value;
	let name = document.updateForm.m_name.value;
	let roadAddr = document.getElementById("roadAddress").value;
	let detailAddr = document.getElementById("detailAddress").value;
	let tel1 = document.updateForm.m_tel1.value; //	010, 017, 016 등
	let tel2 = document.updateForm.m_tel2.value; // 전화 번호 중간 4 자리
	let tel3 = document.updateForm.m_tel3.value; // 전화 번호 끝 4자리
	let tel = tel1+"-"+tel2+"-"+tel3; //세 가지 전화 번호 데이터 값을 tel로 저장
	
	let email = document.updateForm.m_email.value;
	
	let ExpPasswd=/^[A-Za-z0-9!@#$%_]{8,}$/;
	let ExpName=/^[가-힣]*$/;
	let Exptel=/^\d{3}-\d{3,4}-\d{4}$/;
	let ExpEmail=/^[a-zA-Z0-9][a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]{2,}$/;
	
	
	// passwd가 비어있지 않을 때(즉, 사용자가 새 비번을 입력했을 때)만 정규식을 검사함
	if (passwd !== "" && !ExpPasswd.test(passwd)) {
	    alert("부적합한 비밀번호 형식입니다. \n비밀번호는 영문 대소문자와 숫자, 특수기호(!, @, #, $, %, _)를 사용하여 8자리 이상 입력해 주세요");
	    return false;
	}
	
	if(!ExpName.test(name)) {
		alert("이름을 확인하세요\n이름은 한글로만 입력해 주세요");
		return false;
	}
	
	
	if(!Exptel.test(tel)) {
		alert("전화번호를 확인하세요\n전화번호는 숫자만 입력하세요");
		return false;
	}
	
	if(!ExpEmail.test(email)) {
		alert("이메일을 확인하세요\n이메일 입력형식 : abcd@google.com")
		return false;
	}
	
	let fullAddr = roadAddr + " " + detailAddr; // 도로명 주소와 상세 주소를 합쳐서 fullAddr 변수에 저장
	document.updateForm.m_addr.value = fullAddr; 
	document.updateForm.m_tel.value = tel;

	document.updateForm.submit();
}
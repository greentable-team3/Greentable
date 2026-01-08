function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('roadAddress').value = data.roadAddress;
            document.getElementById('detailAddress').focus();
        }
    }).open();
}
function checkpasswd(){
	let passwd = document.update.m_passwd.value;
	let passwd2 = document.update.m_passwd2.value;
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
	let passwd = document.signup.m_passwd.value;
	let name = document.signup.m_name.value;
	let addr = document.getElementById("roadAddress").value;
	let detailAddr = document.getElementById("detailAddress").value;
	let tel1 = document.signup.m_tel1.value; //	010, 017, 016 등
	let tel2 = document.signup.m_tel2.value; // 전화 번호 중간 4 자리
	let tel3 = document.signup.m_tel3.value; // 전화 번호 끝 4자리
	let tel = tel1+"-"+tel2+"-"+tel3; //세 가지 전화 번호 데이터 값을 tel로 저장
	
	let email = document.signup.m_email.value;
	
	let ExpPasswd=/^[A-Za-z0-9!@#$%_]{8,}$/;
	let ExpName=/^[가-힣]*$/;
	let ExpAddr=/^[가-힣0-9a-zA-Z\s-]*$/;
	let Exptel=/^\d{3}-\d{3,4}-\d{4}$/;
	let ExpEmail=/^[a-zA-Z0-9][a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]{2,}$/;
	
	
	if(passwd == ""||!ExpPasswd.test(passwd)) {
		alert("비밀번호를 입력하지 않았거나 부적합한 비밀번호 형식입니다. \n비밀번호는 영문 대소문자와 숫자, 특수기호(!, @, #, $, %, _)를 사용하여 8자리 이상 입력해 주세요");
		return false;
	}
	
	if(name == ""||!ExpName.test(name)) {
		alert("이름을 입력하세요\n이름은 한글로만 입력해 주세요");
		return false;
	}
	
	if(!roadAddr) {
		alert("주소를 입력하세요");
		return false;
	}
	
	if(tel == ""||!Exptel.test(tel)) {
		alert("전화번호를 입력하세요\n전화번호는 숫자만 입력하세요");
		return false;
	}
	
	if(email == ""||!ExpEmail.test(email)) {
		alert("이메일을 입력하세요\n이메일 입력형식 : abcd@google.com")
		return false;
	}
	
	document.signup.submit();
}
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
function checkId() {
    const id = document.getElementById("m_id").value; // 사용자가 입력한 m_id값을 'id'라는 변수에 저장
    const msg = document.getElementById("idMsg"); // "msg"에 넣은 문구를 msg라는 변수에 저장

    if (!id) {
        msg.textContent = ""; // id 값이 없다면 아무 것도 출력하지 않음
        return;
    }

    fetch("/idCheck?m_id=" + encodeURIComponent(id))
	// fetch는 서버에 요청 웹브라우저에서 새로 고침 없이 요청을 보내는 함수, 사용자가 입력한 m_id 값을 서버 요청으로 보냄, encodeURIComponent(id)은 id에 특수 문자 등이 섞여있어도 깨지지 않게 해줌
        .then(res => res.text()) // 서버에서 문자열을 받음, 여기서는 DB에 저장된 사용자의 id값
        .then(result => {
            if (result === "DUPLICATE") { // 결과가 "DUPLICATE"면 , 회원 가입을 희망하는 사람의 id가 이미 DB에 저장이 되었다면
                msg.textContent = "이미 사용 중인 아이디입니다."; // "msg"에 '이미 사용 중인 아이디입니다'라는 문구를 넣음
                msg.style.color = "red"; // 문구의 색
            } else {
                msg.textContent = "사용 가능한 아이디입니다."; // 그외에는 "msg"에 '사용 가능한 아이디입니다'라는 문구를 넣음
                msg.style.color = "green";
            }
        });
}
function checkpasswd(){
	let passwd = document.signup.m_passwd.value;
	let passwd2 = document.signup.m_passwd2.value;
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
		let id = document.signup.m_id.value;
		let passwd = document.signup.m_passwd.value;
		let name = document.signup.m_name.value;
		let tel1 = document.signup.m_tel1.value;
		let tel2 = document.signup.m_tel2.value;
		let tel3 = document.signup.m_tel3.value;
		let tel = tel1+"-"+tel2+"-"+tel3;
		let email = document.signup.m_email.value;
		let roadAddr = document.getElementById("roadAddress").value;
    	let detailAddr = document.getElementById("detailAddress").value;
		
		let ExpId=/^[a-z0-9]*$/;
		let ExpPasswd=/^[A-Za-z0-9!@#$%_]{8,}$/;
		let ExpName=/^[가-힣]*$/;
		// let ExpAddr=/^[가-힣0-9a-zA-Z\s-]*$/;
		let Exptel=/^\d{3}-\d{3,4}-\d{4}$/;
		let ExpEmail=/^[a-zA-Z0-9][a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]{2,}$/;
		
		if(id == ""||!ExpId.test(id)) {
			alert("아이디를 입력하지 않았거나 부적합한 아이디 형식입니다. \n아이디는 영문 소문자나 숫자로 입력해 주세요");
			return false;
		}
		
		if (document.getElementById("idMsg").textContent.includes("이미")) {
		    alert("아이디 중복을 확인하세요.");
		    return false;
		}
		
		if(passwd == ""||!ExpPasswd.test(passwd)) {
			alert("비밀번호를 입력하지 않았거나 부적합한 비밀번호 형식입니다. \n비밀번호는 영문 대소문자와 숫자, 특수기호(!, @, #, $, %, _)를 사용하여 8자리 이상 입력해 주세요");
			return false;
		}
		
		if(name == ""||!ExpName.test(name)) {
			alert("이름을 입력하세요\n이름은 한글로만 입력해 주세요");
			return false;
		}
		
		if(roadAddr == "") {
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

		let fullAddr = roadAddr + " " + detailAddr; // 도로명 주소와 상세 주소를 합쳐서 fullAddr 변수에 저장
    	alert("결합된 주소: " + fullAddr);
		document.signup.m_addr.value = fullAddr; 
		document.signup.m_tel.value = tel;
		return true;

	}
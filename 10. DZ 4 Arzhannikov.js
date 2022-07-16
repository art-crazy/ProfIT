let auth = [];
auth.lenght = 0;
authCount = 0;
let pass;
console.log(auth);
let resultAuth;

function calcHashQwerty(text) {
  let summCode = 0;
  for (let i = 0; i < text.length; i++) {
    summCode += Number(text.charCodeAt(i));
  }

  hash = (summCode % 256).toString(16);

  return hash;
}

function signUp() {
  auth[authCount] = new Array();
  auth[authCount][0] = prompt("Создай имя пользователя");
  auth[authCount][0] = calcHashQwerty(auth[authCount][0]);
  auth[authCount][1] = prompt("Создай пароль");
  auth[authCount][1] = calcHashQwerty(auth[authCount][1]);
  authCount++;
  console.table(auth);
}

function signIn() {
  resultAuth = 0;
  logAuth = prompt("Введи имя пользователя");
  logPass = prompt("Введи пароль");
  logAuth = calcHashQwerty(logAuth);
  logPass = calcHashQwerty(logPass);

  for (let i = 0; i < auth.length; i++) {
    if (logAuth == auth[i][0] && logPass == auth[i][1]) {
      resultAuth = true;
    }
  }

  if (resultAuth == true) {
    alert("Авторизация успешна");
  } else alert("Логин или пароль неверный");
}
/* Из дополнительных материалов к занятию возьмите файл reg-form.html,
      содержащий разметку страницы, включающую две кнопки: «Зарегистрироваться»
      и «Войти», и сохраните его в какую-либо папку на вашем диске.
--
      В этой же папке создайте скрипт, содержащий функции signUp и signIn,
      которые будут вызываться при нажатии соответствующих кнопок, и подключите
      его к файлу reg-form.html.
--
      При нажатии кнопки «Зарегистрироваться» (функция signUp) вам должно быть
      предложено ввести имя пользователя и пароль (используйте для этого метод
      prompt). Введенные вами данные должны сохраняться в глобальном массиве
      объектов (объекты должны хранить пары – имя пользователя и пароль).
--
      Пароль должен храниться в хэшированном виде (используйте для этого
      хэш-функцию из задачи 1).
--
      Предусмотрите возможность регистрации нескольких пользователей (как раз
      для этого и будет использоваться массив).
--
      При нажатии кнопки «Войти» (функция signIn) скрипт должен осуществить
      проверку введенных вами данных и проинформировать вас об успешном входе на
      сайт, либо о неверно набранном пароле или несуществующем имени
      пользователя.  */

// function signUp() {
//   auth[authCount] = {
//     login: prompt("Введи имя пользователя"),
//     pass: prompt("Создай пароль"),
//   };
//   authCount++;
//   console.table(auth);
//   console.log(auth[authCount.log]);
// }

// function signUp() {
//   auth[authCount] = new Array();
//   auth[authCount][0] = prompt("Введи имя пользователя");
//   auth[authCount][1] = prompt("Создай пароль");
//   authCount++;
//   console.table(auth);
// }

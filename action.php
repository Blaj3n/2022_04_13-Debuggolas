<!DOCTYPE html>
<html lang="hu-HU">
    <title>Háttérfeldolgozás</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" type="text/css" href="main.css" />
</head>
<body>
        <?php
		//csatlakozás az adatbázishoz
		$csatlakozas = mysqli_connect('localhost', 'root', '', 'pizzahot');
		//UTF8 beállítása
		$csatlakozas->query("SET NAMES UTF8");
		$csatlakozas->query("set character set UTF8");
		if (mysqli_connect_errno()){
				exit("Csatlakozási hiba!");
		}
		//lekérdezés a felh.név, jelszo egyezésre
		//lekérdezzük a titkosított adatokat
		$user = $_POST['username'];
		$pass = $_POST['password'];
		$lekerdezes = "SELECT * FROM felhasználók WHERE felhNev = '".$user."' AND jelszo = '".md5($pass)."' ";
		$lekerdezes2 = "SELECT * FROM jogosultságok";
		//eredmeny a lekérdezés alapján
		$eredmeny = mysqli_query($csatlakozas, $lekerdezes);
		$eredmeny2 = mysqli_query($csatlakozas, $lekerdezes2);
		echo "<p>Jogosultságok táblája:</p>";
		echo "<table>";
		echo "<tr>
		<th>Azonosító</th>
		<th>Megnevezés</th>
		</tr>";
		while ($row = $eredmeny2->fetch_assoc()){
			echo "<tr>
		<td>".$row["jogAzon"]."</td>
		<td>".$row["megnevezes"]."</td>
		</tr>";
		}
		echo "</table>";
		$sorokSzama = mysqli_num_rows($eredmeny);
		//print_r($eredmeny);
		//objektum-ból asszociatív tömb létrehozása
		$adatok = mysqli_fetch_assoc($eredmeny);
		//print_r($adatok);
		//elágazás a lekérdezés alapján
		if ($sorokSzama < 1){
			echo "Helytelen felhasználói név és/vagy jelszó";
			exit();
		}
		//kiíratás
		$azonosito = $adatok["jogosultsag"];
		if ($azonosito == 1){
			echo "Hello admin!!!";
		}
		else{
			echo "Hello user!!!";
		}
		echo "Hello $user";
		?>
</body>
</html>
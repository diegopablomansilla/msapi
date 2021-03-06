package com.ms.back;

import java.io.BufferedWriter;
import java.io.File;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import com.ms.back.commons.services.ServicesFactory;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class GenerateSQL {

	private static final String DB = "db0";
	private static String pathString = null;

	private static final int CANT_PAIS = 25;
	private static final int CANT_PROVINCIA = 25;
	private static final int CANT_CIUDAD = 5;

	public static void main(String[] args) {

		System.out.println("START");

		try {

			ServicesFactory servicesFactory = new ServicesFactory();
			pathString = servicesFactory.getVars().getSqlTemplatesURL().getPath();

//			insertPais();
//			insertProvincia();
			insertCiudad();
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("END");

	}

	private static void insertPais() throws Exception {

		Statement[] statements = new Statement[CANT_PAIS];

		List<String> nombresExistentes = new ArrayList<String>();

		String sql = "INSERT INTO ms.Pais VALUES (?, ?, ?, ?)";

		char c = 'a';

		for (int i = 0; i < CANT_PAIS; i++) {

			String id = (i + 1) + "";
			Integer numero = (i + 1);
//			String abreviatura = (c + "").toUpperCase() + "" + getRandomInt(1, 9) + "" + getRandomInt(1, 9);
//			String abreviatura = "" + (i + 1);
			String abreviatura = getPalabraCorta(3);
			String nombre = getPalabra(50, nombresExistentes);
			nombresExistentes.add(nombre);

			Statement statement = new Statement();
			statement.setSql(sql);
			statement.addArg(id);
			statement.addArg(numero);
			statement.addArg(abreviatura);
			statement.addArg(nombre);

			statements[i] = statement;

			c++;
		}

		String[] lines = insert(DB, statements);
		escribir(lines, "Pais");
	}

	private static void insertProvincia() throws Exception {

		Statement[] statements = new Statement[CANT_PAIS * CANT_PROVINCIA];

//		List<String> abreviaturaExistentes = new ArrayList<String>();
		List<String> nombreExistentes = new ArrayList<String>();

		String sql = "INSERT INTO ms.Provincia VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		int index = 0;

		for (int p = 0; p < CANT_PAIS; p++) {

//			char c = 'a';

			for (int i = 0; i < CANT_PROVINCIA; i++) {

				String id = (index + 1) + "";
				Integer numero = (index + 1);
//				String abreviatura = (c + "").toUpperCase() + "" + getRandomInt(1, 9) + "" + getRandomInt(1, 9);
//				String abreviatura = getPalabraCorta(3, abreviaturaExistentes);
//				abreviaturaExistentes.add(abreviatura);
				String abreviatura = "" + index;
//				String abreviatura = getPalabraCorta(3);
				String nombre = getPalabra(50, nombreExistentes);
				nombreExistentes.add(nombre);
				Integer numeroAFIP = (index + 1);
				Integer numeroIngresosBrutos = (index + 1);
				Integer numeroRENATEA = (index + 1);
				String pais = ((p + 1) + "");

				Statement statement = new Statement();
				statement.setSql(sql);
				statement.addArg(id);
				statement.addArg(numero);
				statement.addArg(abreviatura);
				statement.addArg(nombre);
				statement.addArg(numeroAFIP);
				statement.addArg(numeroIngresosBrutos);
				statement.addArg(numeroRENATEA);
				statement.addArg(pais);

				statements[index] = statement;

				System.out.println(index);

				index++;

//				c++;
			}
		}

		String[] lines = insert(DB, statements);
		escribir(lines, "Provincia");

	}

	private static void insertCiudad() throws Exception {

		Statement[] statements = new Statement[CANT_PAIS * CANT_PROVINCIA * CANT_CIUDAD];

		List<String> nombreExistentes = new ArrayList<String>();

		String sql = "INSERT INTO ms.Ciudad VALUES (?, ?, ?, ?, ?, ?)";

		int index = 0;

		for (int p = 0; p < CANT_PAIS; p++) {

			for (int pp = 0; pp < CANT_PROVINCIA; pp++) {

				for (int i = 0; i < CANT_CIUDAD; i++) {

					String id = (index + 1) + "";
					Integer numero = (index + 1);
					String nombre = getPalabra(50, nombreExistentes);
					nombreExistentes.add(nombre);
					Object departamento = null;
					if (new Random().nextBoolean()) {
						departamento = getPalabra(50);
					} else {
						departamento = String.class;
					}
					Integer numeroAFIP = (index + 1);
					String provincia = ((pp + 1) + "");

					Statement statement = new Statement();
					statement.setSql(sql);
					statement.addArg(id);
					statement.addArg(numero);
					statement.addArg(nombre);
					statement.addArg(departamento);
					statement.addArg(numeroAFIP);
					statement.addArg(provincia);

					statements[index] = statement;
					
					System.out.println(index);

					index++;

				}

			}
		}

		String[] lines = insert(DB, statements);
		escribir(lines, "Ciudad");

	}

	private static void escribir(String[] lines, String fileName) {
//		String[] lines = new String[] { "line 1", "line 2", "line 2" };

//		List<String> linesList = new ArrayList<String>();

		String filePath = pathString + File.separatorChar + "insert_" + fileName + ".sql";

//		Path path = Paths.get(filePath);
//
//		try (Stream<String> stream = Files.lines(path)) {
//			stream.forEach(s -> {
//				linesList.add(s);
//			});
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//
//		for (String line : lines) {
//			linesList.add(line);
//		}

		Path path = Paths.get(filePath);
		try (BufferedWriter br = Files.newBufferedWriter(path, Charset.defaultCharset(), StandardOpenOption.CREATE)) {

			br.write("-- ---------------------------------------------------------------------");
			br.newLine();

			for (String line : lines) {
				if (line.endsWith(";") == false) {
					line = line + ";";
				}
				br.write(line);
				br.newLine();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String[] insert(String db, Statement[] statements) throws Exception {

		// -----------------------------------------------------------------------------

		String[] lines = new String[statements.length];

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			dataBase.beginTransaction();

			for (int i = 0; i < statements.length; i++) {
				dataBase.insert(statements[i]);
				lines[i] = statements[i].getSql();
			}

			dataBase.commitTransaction();

			return lines;

			// ------------------------------------------------------------------------

		} catch (Exception e) {
			if (dataBase != null) {
				dataBase.rollBackTransaction();
			}
			throw e;
		} finally {
			try {
				if (dataBase != null) {
					dataBase.disconnect();
				}
			} catch (Exception e) {
				throw e;
			}
		}

	}

	private static List<String> getPalabrasCortasList(int maxLength, List<String> palabrasExistentes) {

		List<String> palabrasList = new ArrayList<String>();

		for (String palabra : palabras) {

			palabra = palabra.trim();

			if (palabra.length() > maxLength) {
				palabra = palabra.substring(0, maxLength);
			}

			if (palabrasExistentes.size() > 0) {

				boolean b = true;

				for (String palabraExistente : palabrasExistentes) {
					if (palabraExistente.toLowerCase().equals(palabra.toLowerCase())) {
						b = false;
						break;
					}
				}

				if (b) {
					palabrasList.add(palabra);
				}

			} else {
				palabrasList.add(palabra);
			}
		}

		return palabrasList;

	}

//	private static String getPalabraCorta(int maxLength, List<String> palabrasExistentes) {
//
//		List<String> palabras = getPalabrasCortasList(maxLength, palabrasExistentes);
//
//		if (palabras.size() > 0) {
//
//			if (palabras.size() == 1) {
//				int n = 0;
//				String palabra = palabras.get(n);
//				return palabra;
//			} else {
//				int n = getRandomInt(0, palabras.size() - 1);
//				String palabra = palabras.get(n);
//				return palabra;
//			}
//
//		}
//
//		System.out.println(palabras.size());
//		System.out.println(palabras);
//
//		System.exit(0);
//		return null;
//
//	}

	private static List<String> getPalabrasList(int maxLength, List<String> palabrasExistentes) {

		List<String> palabrasList = new ArrayList<String>();

		for (String palabra : palabras) {

			palabra = palabra.trim();

			if (palabra.length() <= maxLength) {

				if (palabrasExistentes.size() > 0) {

					boolean b = true;
					for (String palabraExistente : palabrasExistentes) {

						if (palabraExistente.toLowerCase().equals(palabra.toLowerCase())) {
							b = false;
							break;
						}
					}

					if (b) {
						palabrasList.add(palabra);
					}

				} else {
					palabrasList.add(palabra);
				}

			}
		}

		return palabrasList;

	}

	private static String getPalabraCorta(int maxLength) {
		String uuid = UUID.randomUUID().toString();

		if (maxLength > uuid.length()) {
			maxLength = uuid.length();
		}

		uuid = uuid.substring(0, maxLength);
		return uuid.toUpperCase();
	}

	private static String getPalabra(int maxLength) {
		return getPalabra(maxLength, new ArrayList<String>());
	}

	private static String getPalabra(int maxLength, List<String> palabrasExistentes) {

		List<String> palabras = getPalabrasList(maxLength, palabrasExistentes);

		if (palabras.size() > 0) {
			int n = getRandomInt(0, palabras.size() - 1);
			String palabra = palabras.get(n);

			int dif = maxLength - (palabra + " ").length();

			if (dif > 0) {

				String uuid = UUID.randomUUID().toString().substring(0, 4);

				if (dif > uuid.length()) {
					dif = uuid.length();
				}

				uuid = uuid.substring(0, dif);
				palabra += " " + uuid.toUpperCase();
			}

//			if (palabra.length() < maxLength - 1) {
//				palabra += " " + getRandomInt(1, 9);
//			}
//
//			if (palabra.length() < maxLength - 1) {
//				palabra += "" + getRandomInt(1, 9);
//			}
//
//			if (palabra.length() < maxLength - 1) {
//				palabra += "" + getRandomInt(1, 9);
//			}

			return palabra;
		}

		System.out.println(palabras);

		System.exit(0);
		return null;

	}

	private static String getPalabrax(int maxLength, List<String> palabrasExistentes) {
		String palabra = null;

		boolean siguiente = false;

		do {

			int n = getRandomInt(0, palabras.length - 1);
			palabra = palabras[n].trim();

			if (palabra.length() > maxLength) {
				siguiente = true;
			} else {

				for (String palabraExistente : palabrasExistentes) {
					if (palabraExistente.equals(palabra)) {
						siguiente = true;
						break;
					}
				}

			}

			System.out.println(palabra);

		} while (siguiente);

		return palabra;

	}

	private static int getRandomInt(int min, int max) {
		Random random = new Random();

		return random.nextInt(max - min) + min;
	}

	private static String[] palabras = {

			"Almendra", "Arena", "Bistre1?", "Bistre español", "Café (específico)", "Castaño (específico)", "Pardo",
			"Ante o marrón claro", "Bronce", "Barbecho", "Gamuza", "Beis o beige", "Caoba", "Caqui", "Caqui claro",
			"Caqui oscuro", "Canela o canelo", "Chocolate", "Herrumbre", "León o leonado", "Marrón", "Marrón cuero",
			"Marrón dorado", "Marrón claro", "Marrón medio", "Marrón oscuro", "Marrón pálido", "Marrón sepia", "Melado",
			"Ocre", "Ocre amarillo (específico)", "Ocre amarillo (pictórico)", "Ocre rojo", "Ocre pardo",
			"Ocre pardo oscuro", "Ocre oro", "Ocre dorado", "Ocre dorado tostado", "Ocre carne", "Pardo ocre",
			"Pardo verdoso", "Perú", "Rufo", "Secuoya", "Sepia (específico)", "Sepia (pictórico)", "Siena",
			"Siena tostado", "Tabaco", "Treviso", "Wengué", "Acicoria", "Achicoria", "Albero", "Rojo", "Almagre",
			"Bermejo", "Bermellón", "Bermellón de China", "Bermellón holandés o Punzó", "Burdeos o bordó", "Vino",
			"Carmesí", "Carmín (estándar)", "Carmín (pictórico)", "Carmín de alizarina", "Rojo Munsell", "Coral",
			"Escarlata", "Escarlata Gobelinos", "Frambuesa", "Granate", "Grana", "Hematita roja", "Hígado",
			"Rojo Falun", "Rojo indio", "Rojo persa", "Rojo puro", "Rojo toscano", "Rojo veneciano",
			"Tomate o cartamina", "Rojo filipino", "Rojo sandía", "Rojo anaranjado", "Rojo anaranjado (estándar)",
			"Naranja eléctrico", "Rojo naranja", "Rojo naranja (estándar)", "Naranja Rojizo",
			"Naranja rojizo (estándar)", "Aleación de naranjo", "Ámbar (estándar)", "Calabaza (específico)",
			"Calabaza (inespecífico)", "Albaricoque", "Naranja caqui (específico)", "Naranja caqui (inespecífico)",
			"Naranja", "Naranja vivo", "Naranja (obscuro)", "Naranja claro", "Naranja medio", "Naranja oscuro",
			"Dorado", "Llama", "Salmón", "Amarillo", "Amarillo canario", "Amarillo claro", "Amarillo crema",
			"Amarillo de plata", "Amarillo filipino", "Amarillo indio", "Amarillo limón", "Amarillo medio",
			"Amarillo oscuro", "Amarillo puro", "Ámbar", "Arilado 2?", "Áureo", "Aureolina", "Cadmín", "Cetrino",
			"Chartreuse", "Colza", "Crema", "Cromato", "Dorado", "Flavo3?", "Gualdo4?", "Gutagamba", "Hansa",
			"Junquillo", "Limón (estándar)", "Mostaza", "Mostaza claro", "Mostaza oscuro", "Napoleto", "Napoleto claro",
			"Napoleto oscuro", "Napoleto rojizo", "Oro", "Amarillo verdoso", "Verde amarillo", "Verde amarillento",
			"Verde ácido", "Cartujo o Chartreuse francés", "Cetrino", "Lima", "Limón (estándar)", "Verde oliva5?",
			"Verde eléctrico", "Verde medio", "Sinople o Verde estándar", "Prásino verde claro brillante",
			"Víride o verde oscuro", "Glauco o verde claro opaco", "Verde oscuro (web)5?", "Porráceo6? o vde. profundo",
			"Malaquita7?", "Esmeralda claro", "Esmeralda", "Verde bosque5? o foresta", "Jade", "Pistacho8?",
			"Glauco,9? o verde helecho10?", "Verde musgo11?", "Verde musgo viejo", "Menta12?",
			"Verdín13? o verde pastel14?", "Verde loro15?", "Verde lima oscuro", "Verde botella16?", "Verde mar17?",
			"Verde Hooker Nº1", "Verde Hooker Nº2", "Oliva", "Verde primavera", "Veronese", "Verde de Schweinfurt",
			"Verde de París", "Viridián o verde oxidado", "Viridián español", "Viridián (inespecífico)",
			"Verde ceniza (pictórico)", "Verde ceniza (específico)", "Cardenillo o verde gris", "Teal o verde pino",
			"Teal (obscuro)", "Verde de Scheele", "Verde islámico", "Verde ruso", "Esmeralda claro", "Turquesa",
			"Aguamarina", "Aguamarina pantone", "Verde cian", "Cian suave", "Cerceta o Verde azulado", "Aero",
			"Aero azul", "Aguamarina", "Aguamarina oriental", "Azul turquesa", "Bígaro", "Calipso", "Celeste",
			"Celeste claro", "Cerúleo (específico)", "Cerúleo (inespecífico)", "Cian (aditivo)", "Cian (estándar)",
			"Turquesa", "Turquesa claro", "Turquesa medio", "Turquesa oscuro", "Turquesa pálido", "Verde turquesa",
			"Azul", "Azul claro", "Azul eléctrico", "Azul eléctrico oscuro", "Azul medio", "Azul rey", "Azul oscuro",
			"Azul pálido", "Azul PRU", "Azur", "Añil", "Cobalto (específico)", "Azul cobalto (pictórico)",
			"Cobalto claro (pictórico)", "Cobalto obscuro (pictórico)", "Azul de Prusia", "Azul Majorelle",
			"Azul glauco", "Azul marino (pictórico)", "Azul marino (específico)", "Cero absoluto", "Azul cerúleo",
			"Índigo (específico)", "Índigo (pictórico)", "Orcela", "Turquí", "Zafiro (inespecífico)", "Azul Munsell",
			"Azul celeste", "Azul imperial", "Teal azul", "Azul purpúreo", "Azul purpúreo (estándar)", "Azul púrpura",
			"Azul púrpura (estándar)", "Púrpura azulado", "Púrpura azulado (estándar)", "Amaranto púrpura profundo",
			"Aciano", "Amatista", "Lavanda", "Lila", "Lila brillante", "Lila claro", "Lila francés", "Lila intenso",
			"Lila lavanda", "Lila pálido", "Lirio", "Malva", "Morado (inespecífico)", "Morado (inespecífico, otro)",
			"Patriarca", "Púrpura", "Púrpura de Perkin", "Púrpura de Tiro", "Púrpura medio", "Púrpura oscuro",
			"Púrpura pálido", "Uva", "Violeta", "Violeta africana", "Violeta claro", "Violeta intenso", "Violeto medio",
			"Violeta oscuro", "Violeta pálido", "Violín", "Zafiro (estándar)", "Amaranto (color)", "Amaranto rosado",
			"Crisvilu o carne", "Magenta", "Magenta (estándar)", "Magenta cielo", "Magenta claro", "Magenta intenso",
			"Magenta neon", "Magenta oscuro", "Magenta pálido", "Rosa (estándar)", "Rosa vivo", "Rosa (inespecífico)",
			"Rosado", "Rosado encaje", "Rosado pictórico", "Fucsia", "Fucsia rojizo", "Orceína", "Rosa coral",
			"Rosa mexicano", "Salmón", "Púrpura rojizo", "Rojo púrpura", "Rojo purpúreo", "Alabastro",
			"Albo o blanco apagado", "Azul Alicia (Blanco azul frío)", "Blanco", "Blanco antigua", "Blanco de zinc",
			"Blanco navajo", "Blanco yeso", "Concha", "Lanquecino (blco menta)", "Encaje antiguo", "Hueso",
			"Humo blanco", "Marfil", "Nácar", "Nieve", "Blanco de titanio", "Aluminio", "Ceniza", "Gris",
			"Gris atenuado", "Gris de Davy", "Sulfán", "Gris claro", "Gris frío", "Gris medio", "Gris oscuro",
			"Plata antiguo", "Plateado", "Platino", "Plomo", "Sulfán oscuro", "Lino", "Xanadú", "Gris brillante",
			"egro", "Azabache o negro brillante", "Negro verdoso", "Carbón", "Ébano18?", "Grafito (RAL)", "Cordobán",
			"Negro bujía", "Negro azulado", "Negro de humo", "Negro chino", "Negro de pasas", "Negro rojizo",
			"Antracita negro-gris metálico", "Sustantivos", "Gente", "humanidad", "humano", "persona", "gente",
			"hombre", "mujer", "bebé", "niño, niña", "adolescente", "adulto, adulta", "anciano, anciana", "don, doña",
			"señor, señora", "caballero", "dama", "Cuerpo humano y salud", "cuerpo", "pierna", "pie", "talón",
			"espinilla", "rodilla", "muslo", "cabeza", "cara", "boca", "labio", "diente", "ojo", "nariz", "barba",
			"bigote", "cabello", "oreja", "cerebro", "estómago", "brazo", "codo", "hombro", "uña", "mano", "muñeca",
			"palma", "dedo", "trasero, cola, glúteos", "abdomen", "hígado", "músculo", "cuello", "corazón", "mente",
			"alma", "espíritu", "pecho", "cintura", "cadera", "espalda", "corazón", "sangre", "carne", "piel", "hueso",
			"resfriado", "gripe", "diarrea", "salud", "enfermedad", "Familia y otras relaciones", "familia",
			"amigo, amiga", "conocido, conocida", "colega", "pareja", "esposo, esposa", "matrimonio", "amor", "padre",
			"madre", "hermano, hermana", "hijo, hija", "abuelo, abuela", "bisabuelo, bisabuela", "nieto, nieta",
			"bisnieto, bisnieta", "primo, prima", "tío, tía", "sobrino, sobrina", "Vida", "criatura", "especie", "ser",
			"vida", "nacimiento", "reproducción", "muerte", "Geografía", "naturaleza", "campo", "bosque",
			"selva, jungla", "desierto", "costa", "playa", "río", "laguna, lago", "mar, océano",
			"cerro, monte, montaña", "luz", "energía", "Animales", "animal", "perro", "gato", "vaca", "cerdo",
			"caballo, yegua", "oveja", "mono", "ratón, rata", "tigre", "conejo", "dragón", "ciervo", "rana", "león",
			"jirafa", "elefante", "pájaro", "gallina", "gorrión", "cuervo", "águila", "halcón", "pez", "camarón",
			"langosta", "sardina", "atún", "calamar", "pulpo", "insecto", "bicho", "mariposa", "polilla", "saltamontes",
			"araña", "mosca", "mosquito", "cucaracha", "caracol", "babosa", "lombriz", "marisco", "molusco", "lagarto",
			"serpiente", "cocodrilo", "Plantas y alimentos", "alimento", "comida", "bebida", "vegetal", "planta",
			"pasto, césped", "flor", "fruta", "semilla", "árbol", "hoja", "raíz", "tallo", "hongo", "ciruela", "pino",
			"bambú", "nuez", "almendra", "castaña", "arroz", "avena", "cebada", "trigo", "verdura", "patatas, papas",
			"judías, guisantes, porotos", "rábano", "zanahoria", "manzana", "naranja", "plátano", "pera", "castaño",
			"durazno", "tomate", "sandía", "carne", "gaseosa", "Tiempo", "tiempo", "calendario", "edad", "época, era",
			"fecha", "instante", "momento", "segundo", "minuto", "hora", "día", "semana", "entre semana",
			"fin de semana", "mes", "año", "década", "siglo", "milenio", "ayer", "hoy", "mañana", "amanecer",
			"mediodía", "tarde", "anochecer", "noche", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado",
			"domingo", "Espacio", "ambiente", "espacio", "entorno", "área", "superficie", "volumen", "región", "zona",
			"lado", "mundo", "planeta", "sol", "luna", "estrella", "galaxia", "universo", "clima", "despejado",
			"nublado", "lluvia", "nieve", "viento", "trueno", "rayo", "tormenta", "cielo", "este", "oeste", "sur",
			"norte", "derecha", "izquierda", "diagonal", "exterior", "interior", "Materiales", "calor", "agua", "hielo",
			"vapor", "fuego", "gas", "aire, atmósfera", "tierra", "piso", "suelo", "metal, metálico", "hierro", "oro",
			"plata", "plomo", "sal", "barro, lodo", "Medidas", "peso", "metro", "milímetro, centímetro, kilómetro",
			"litro", "gramo", "kilo", "cantidad", "total", "medida", "Sociedad", "sociedad", "comunidad", "reunión",
			"encuentro", "estructura", "administración", "organización", "asociación", "empresa", "equipo", "autoridad",
			"cargo", "campaña", "club", "comisión", "congreso", "consejo", "partido", "país", "nación", "gobierno",
			"estado", "provincia", "departamento", "municipio", "democracia", "dictadura", "política", "político",
			"presidente", "ministro", "director", "parlamentario, congresista, senador, diputado", "representante",
			"gobernador, intendente, alcalde", "policía", "bomberos", "capital", "ciudad", "población", "pueblo",
			"villa", "obligación", "libertad", "derecho", "permiso", "prohibición", "constitución", "ley", "decreto",
			"norma", "Economía", "economía", "consumo", "demanda", "compañía", "comercio", "mercado", "servicio",
			"producto", "producción", "transacción", "almacén", "hotel", "fábrica", "cuenta", "boleto", "entrada",
			"dinero", "billete", "vuelto, cambio", "máquina expendedora", "precio, tarifa", "valor",
			"Objetos hechos por el ser humano", "Hogar", "escritorio", "silla", "mesa", "cama", "dormitorio",
			"habitación", "cuarto", "oficina", "panel", "puerta", "ventana", "entrada", "hogar", "casa",
			"apartamento, departamento", "edificio", "construcción", "elevador, ascensor", "escalera", "Herramientas",
			"aparato", "cámara", "aguja", "clavo", "hilo", "cuerda, cordel, cordón", "bolsillo", "bolso", "bolsa",
			"paraguas", "parasol", "pantalla", "pomo", "llave", "trancar", "arma", "escultura", "libro", "revista",
			"cuadro", "grabado", "electricidad", "corriente", "base", "pata", "conexión", "Ropa", "ropa", "prenda",
			"manga", "solapa, cuello", "botón", "cremallera, cierre", "cinturón", "zapato", "gafas", "pantalón",
			"camisa", "camiseta", "zapatilla", "cordones", "abrigo", "chaqueta", "calcetines", "bragas, calzón",
			"calzoncillo", "sujetador, sostén", "falda", "Transportes",
			"transporte, transporte público, transporte privado", "tránsito, tráfico", "vehículo", "tren, ferrocarril",
			"subterráneo, metro", "camino", "vía", "ruta", "calle", "carretera", "autopista", "avenida",
			"estación, parada", "avión", "aeropuerto", "automóvil, coche, auto", "bus, autobús, ómnibus", "ambulancia",
			"Lenguaje", "número", "alfabeto", "símbolo", "punto", "coma", "raíz, origen, fuente", "papel", "carta",
			"comunicación", "expresión", "voz", "texto", "periodismo", "periódico, diario", "diccionario", "documento",
			"informe", "noticia", "computadora, ordenador", "idioma extranjero", "japonés", "inglés", "chino", "alemán",
			"español", "francés", "Colores", "color", "blanco", "negro", "gris", "rojo", "naranja, anaranjado",
			"amarillo", "verde", "celeste", "azul", "violeta", "rosa, rosado", "marrón, café", "Actividades", "cultura",
			"autor", "actuación", "espectador", "espectáculo", "entretenimiento", "arte", "cine", "dibujo", "pintura",
			"música", "religión", "dios", "artículo", "educación", "escuela", "instituto", "colegio", "universidad",
			"clase", "curso", "estudio", "formación", "análisis", "investigación", "conocimiento", "idea",
			"información", "dato", "forma", "manera", "modo", "estilo", "figura", "elemento", "uso, utilización",
			"ciencia", "aritmética", "historia", "geografía", "educación física", "deporte", "carrera",
			"competición, competencia", "ayuda", "favor", "apoyo", "búsqueda", "duda", "pregunta", "respuesta",
			"cuestión", "solicitud", "decisión", "elección", "consejo", "sugerencia", "orden", "control", "sistema",
			"trabajo", "empleo", "profesión", "esfuerzo", "Números", "cero", "uno", "dos", "tres", "cuatro", "cinco",
			"seis", "siete", "ocho", "nueve", "diez", "cien, ciento", "mil", "millón", "Espacio y cantidad", "lugar",
			"posición", "movimiento", "velocidad", "aceleración", "dirección", "tamaño", "largo, longitud",
			"alto, altura", "ancho", "mayoría", "minoría", "aumento", "reducción", "crecimiento", "fondo", "frente",
			"Sustantivos abstractos", "cosa", "aspecto", "contenido", "objeto", "parte", "sector", "palabra", "nombre",
			"código", "secreto", "formalidad", "presente", "pasado", "futuro", "ocasión", "vez", "acción", "actividad",
			"acto", "programa", "proyecto", "obra", "acuerdo", "actitud", "atención", "capacidad", "concepto", "tema",
			"condición", "caso", "conjunto", "grupo", "creación", "destrucción", "origen", "destino", "objetivo, meta",
			"función", "relación", "realidad", "situación", "problema", "intento", "solución", "efecto", "resultado",
			"logro", "éxito", "fracaso", "causa", "consecuencia", "beneficio", "perjuicio", "calidad", "tipo", "ataque",
			"defensa", "paz", "conflicto", "guerra", "carácter", "característica", "crisis", "cambio", "desarrollo",
			"progreso", "avance", "retroceso", "mejora", "deterioro", "comienzo, inicio, principio", "transcurso",
			"fin, final, cabo", "etapa", "fase", "paso", "serie", "secuencia", "grado", "nivel", "proceso", "corte",
			"interrupción", "espera", "diferencia", "similitud", "sentido", "sensación", "vista", "oído", "tacto",
			"olfato", "dolor", "conciencia", "percepción", "imagen", "fuerza", "potencia", "presencia", "existencia",
			"experiencia", "posibilidad", "probabilidad", "verdad", "mentira", "razón", "acierto", "equivocación",
			"necesidad", "falta", "significado", "carácter", "personalidad", "pensamiento", "memoria", "recuerdo",
			"deseo", "alegría", "tristeza", "enojo, enfado", "placer, éxtasis", "empatía", "interés", "aburrimiento",
			"cansancio", "sorpresa", "susto", "seguridad", "confianza", "miedo, temor", "ejemplo", "Adjetivos",
			"Adjetivos de calidad", "bueno, buen", "malo", "superior", "inferior", "central", "lateral", "frontal",
			"trasero, posterior", "cierto", "real", "mayor", "menor", "importante", "necesario", "absoluto", "relativo",
			"caro", "barato", "viejo", "joven", "nuevo", "cada", "cualquier", "dado", "actual", "reciente", "capaz",
			"fácil, simple, sencillo", "difícil, complicado", "posible", "imposible", "probable", "improbable",
			"estricto", "serio", "general", "particular", "común", "especial", "usual", "único", "raro, extraño",
			"fuerte", "débil", "correcto, acertado", "incorrecto, desacertado", "contrario, opuesto, inverso", "igual",
			"diferente, distinto", "parecido, similar", "otro", "diverso", "manual", "automático", "universal",
			"mundial", "continental", "internacional", "nacional", "regional", "local", "urbano", "rural", "social",
			"político", "cultural", "artístico", "propio", "ajeno", "público", "privado", "Adjetivos de forma", "alto",
			"bajo", "gran", "grande", "pequeño", "amplio", "angosto", "compacto", "delgado", "grueso",
			"Adjetivos sensoriales", "caliente", "frío", "ligero", "pesado", "suave", "firme", "flexible", "duro",
			"blando", "caluroso", "frío", "fresco", "delicioso, apetitoso", "horrible", "dulce", "picante", "salado",
			"amargo", "anterior", "posterior", "siguiente", "cercano", "lejano", "junto", "unido", "separado",
			"alejado", "Adjetivos de sentimientos y sensaciones", "feliz", "triste", "solo", "solitario", "contento",
			"tranquilo", "enojado, enfadado", "calmo", "agitado", "ansioso", "interesado", "aburrido", "encantado",
			"cansado", "sorprendido", "asustado, atemorizado", "doloroso", "picante, ardiente", "apestoso, maloliente",
			"Adjetivos ordinales", "primer, primero, primera", "segundo", "tercero", "cuarto", "quinto", "décimo",
			"centésimo", "millonésimo", "penúltimo", "último", "Adjetivos posesivos", "mi", "tu", "su",
			"nuestro, nuestra", "vuestro, vuestra", "Verbos", "Auxiliares", "ser", "estar", "haber", "Existencia",
			"aparecer", "desaparecer", "existir", "cambiar", "crecer", "vivir", "nacer", "morir", "Movimiento", "ir",
			"venir", "volver", "partir", "llegar", "llevar", "traer", "mover", "arrojar", "lanzar", "coger", "agarrar",
			"poner", "quitar, sacar", "alcanzar", "acercar", "alejar", "lanzar", "arrojar", "lanzar", "coger",
			"agarrar", "sujetar", "golpear", "patear", "poner", "quitar, sacar", "alcanzar", "acercar", "alejar",
			"recoger", "levantar", "tomar", "pegar", "Sensaciones", "sentir", "ver", "oír, escuchar", "tocar", "oler",
			"percibir", "Emociones", "amar", "querer", "desear", "odiar, detestar", "entristecerse", "llorar", "reír",
			"enojarse, enfadarse", "admirar, alabar, elogiar", "alegrarse", "encantarse", "consolar", "interesarse",
			"aburrirse", "cansarse", "sorprenderse", "asustarse, atemorizarse", "Actividades", "comunicarse", "afirmar",
			"negar", "decir", "hablar", "callar", "escribir", "leer", "analizar", "pensar", "cantar", "señalar",
			"apuñalar", "morder", "clavar", "comer", "beber", "acordar", "afectar", "generar", "añadir, agregar",
			"mejorar", "empeorar", "seguir", "avanzar", "retroceder", "ayudar", "complicar", "reunirse", "entrevistar",
			"abrir, desenvolver", "jugar", "tener", "faltar", "dar", "recibir", "romper", "doblar", "cortar", "comprar",
			"vender", "llevar puesto", "cambiar", "intercambiar", "sustituir, reemplazar", "cerrar", "buscar",
			"encontrar", "obtener, conseguir", "crear", "creer", "comenzar, iniciar, empezar", "terminar, acabar",
			"abandonar", "dejar", "entrar", "quedarse", "salir", "atender", "medir", "pesar", "considerar", "comparar",
			"evaluar", "decidir", "construir", "destruir", "deber", "poder", "conocer", "entender, comprender", "atar",
			"saber", "trabajar", "separar, dividir, partir", "descansar", "dormir", "despertar", "aceptar", "rechazar",
			"descartar", "acompañar", "pedir, solicitar", "pretender", "proponer", "sugerir", "usar, utilizar", "hacer",
			"fabricar", "arreglar, reparar", "explicar", "mostrar", "tratar", "evitar", "probar, intentar",
			"comprobar, verificar", "variar", "esperar", "necesitar, precisar", "significar", "parecer", "distinguir",
			"Adverbios", "Adverbios de cantidad", "más", "menos", "muy", "mucho", "poco", "apenas", "algo", "casi",
			"aproximadamente", "exactamente", "bastante", "justo", "demasiado", "etcétera", "solo, solamente", "tan",
			"tanto", "todo", "nada", "cómo", "cuándo", "cuánto", "cuál, cuáles", "dónde", "Adverbios de calidad",
			"bien", "mal", "mejor", "peor", "regular", "despacio", "deprisa", "tal", "como", "adrede", "claro",
			"exacto", "obvio", "inclusive", "además", "asimismo", "únicamente", "especialmente", "incluso", "viceversa",
			"siquiera", "inicialmente", "finalmente", "Adverbios de posibilidad", "siempre", "nunca", "jamás",
			"también", "tampoco", "quizá, quizás", "acaso", "fácilmente", "difícilmente", "probablemente",
			"posiblemente", "seguramente", "Adverbios temporales", "antes", "anteriormente", "actualmente", "ahora",
			"enseguida", "inmediatamente", "ya", "todavía", "aún", "recién", "mientras", "después", "luego", "pronto",
			"tarde", "temprano", "ayer", "anoche", "hoy", "mañana", "de nuevo", "próximamente",
			"Adverbios de ubicación", "arriba, encima", "abajo, debajo", "adelante, delante", "atrás, detrás",
			"centro, medio", "alrededor", "enfrente", "cerca", "lejos", "adentro, dentro", "afuera, fuera", "aquí",
			"acá", "ahí", "allá", "allí", "Otros adverbios", "así", "adónde", "dónde", "Preposiciones", "a, al", "ante",
			"bajo", "con", "contra", "de, del", "desde", "durante", "en", "entre", "hacia", "hasta", "mediante", "para",
			"por", "según", "sin", "sobre", "tras", "Conjunciones", "aunque", "como", "cuando", "entonces", "excepto",
			"ni", "o", "pero", "porque", "pues", "que", "salvo", "si", "sino", "y", "Pronombres",
			"Pronombres personales", "yo", "tú", "vos", "usted", "él, ella, ello", "nosotros, nosotras",
			"vosotros, vosotras", "ustedes", "ellos, ellas", "mí, conmigo", "ti, contigo", "sí, consigo", "me", "te",
			"le, la, lo", "se", "nos", "os", "Pronombres posesivos", "mío, mía", "tuyo, tuya", "suyo, suya",
			"nuestro, nuestra", "vuestro, vuestra", "cuyo, cuya", "Pronombres indefinidos", "un, una, uno",
			"algún, alguna, algo", "ninguno, ninguna, nada", "varios, varias", "otro, otra", "mismo, misma",
			"tan, tanto, tanta", "alguien", "nadie", "cualquiera", "ambos", "demás", "Pronombres interrogativos",
			"cuál", "cuánto", "quién", "qué", "Demostrativos", "este, esta, esto", "estos, estas", "ese, esa, eso",
			"esos, esas", "aquel, aquella, aquello", "aquellos, aquellas", "Interjecciones", "sí", "no", "Locuciones",
			"gracias", "acerca de", "a lo mejor", "a menudo", "a pesar de", "a propósito", "a través de", "dado que",
			"es decir", "ni siquiera", "o sea", "por cierto", "por ejemplo", "por favor", "por tanto", "sin embargo",
			"tal vez", "ya que", "Sidra", "Chinchón conga", "Cerveza", "Pulque", "Pelin", "Vino", "Ratafía", "Mariete",
			"Vermút", "Jerez", "Vino de arroz", "Vino de Oporto", "Vodka Azul o Rojo", "Cherry Heering", "Pacharán",
			"Palo", "Punsch", "Aguardiente", "Limoncello", "Tía María", "Pisco", "Caña", "Jägermeister", "Chinchón",
			"Ginebra", "Brandy", "Ron", "Tequila", "Bourbon", "Vodka", "Becherovka", "Gin de Menorca", "Aquavit",
			"Grappa", "Ouzo", "Cachaza/Cachaça", "Fernet", "Coñac", "Orujo blanco", "Whisky", "Licor de cocuy",
			"Bacanora", "Mezcal", "Absenta", "Chinchón seco especial", "Vodka Spirytus", "Cocoroco" };

}

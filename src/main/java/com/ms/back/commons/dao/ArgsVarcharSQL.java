package com.ms.back.commons.dao;

import java.util.ArrayList;
import java.util.List;

public class ArgsVarcharSQL {

	// String translate =
	// ",'/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
	// '
	// aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'";
	private final String TRANSLATE = ",'/\"'';,_-.âãäåàáÁÂÃÄÅÀèééêëÉÈËÊìíîïìÌÍÎÏÌóôõöòÒÓÔÕÖùúûüÙÚÛÜçÇñÑ', '        aaaaaaAAAAAAeeeeeEEEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnN'";

	public static final String OP_EQ = "EQ";
	public static final String OP_SW = "SW";
	public static final String OP_EW = "EW";
	public static final String OP_C = "C";

	public static final String OP_EQ_IC = "EQ_IC";
	public static final String OP_SW_IC = "SW_IC";
	public static final String OP_EW_IC = "EW_IC";
	public static final String OP_C_IC = "C_IC";

	public static final String OP_EQ_T = "EQ_T";
	public static final String OP_SW_T = "SW_T";
	public static final String OP_EW_T = "EW_T";
	public static final String OP_C_T = "C_T";

	public static final String OP_EQ_ICT = "EQ_ICT";
	public static final String OP_SW_ICT = "SW_ICT";
	public static final String OP_EW_ICT = "EW_ICT";
	public static final String OP_C_ICT = "C_ICT";

	// ------------------

	public static final String OP_EQ_A = "EQ_A";
	public static final String OP_SW_A = "SW_A";
	public static final String OP_EW_A = "EW_A";
	public static final String OP_C_A = "C_A";

	public static final String OP_EQ_IC_A = "EQ_IC_A";
	public static final String OP_SW_IC_A = "SW_IC_A";
	public static final String OP_EW_IC_A = "EW_IC_A";
	public static final String OP_C_IC_A = "C_IC_A";

	public static final String OP_EQ_T_A = "EQ_T_A";
	public static final String OP_SW_T_A = "SW_T_A";
	public static final String OP_EW_T_A = "EW_T_A";
	public static final String OP_C_T_A = "C_T_A";

	public static final String OP_EQ_ICT_A = "EQ_ICT_A";
	public static final String OP_SW_ICT_A = "SW_ICT_A";
	public static final String OP_EW_ICT_A = "EW_ICT_A";
	public static final String OP_C_ICT_A = "C_ICT_A";

	// ------------------

	public static final String OP_EQ_O = "EQ_O";
	public static final String OP_SW_O = "SW_O";
	public static final String OP_EW_O = "EW_O";
	public static final String OP_C_O = "C_O";

	public static final String OP_EQ_IC_O = "EQ_IC_O";
	public static final String OP_SW_IC_O = "SW_IC_O";
	public static final String OP_EW_IC_O = "EW_IC_O";
	public static final String OP_C_IC_O = "C_IC_O";

	public static final String OP_EQ_T_O = "EQ_T_O";
	public static final String OP_SW_T_O = "SW_T_O";
	public static final String OP_EW_T_O = "EW_T_O";
	public static final String OP_C_T_O = "C_T_O";

	public static final String OP_EQ_ICT_O = "EQ_ICT_O";
	public static final String OP_SW_ICT_O = "SW_ICT_O";
	public static final String OP_EW_ICT_O = "EW_ICT_O";
	public static final String OP_C_ICT_O = "C_ICT_O";

	// ------------------

	private List<String> srcs = new ArrayList<String>();
	private List<String> values = new ArrayList<String>();
	private String operatorSQL;

	public ArgsVarcharSQL(String op, String name, String originalValue) {
		if (originalValue != null) {
			build(op, name, originalValue);
		}
	}

	public String getValue() {
		if (this.size() > 0) {
			return srcs.get(0);
		}

		return null;

	}

	public String getSrc() {
		if (this.size() > 0) {
			return values.get(0);
		}

		return null;
	}

	public List<String> getSrcs() {
		return srcs;
	}

	public List<String> getValues() {
		return values;
	}

	public int size() {
		return values.size();
	}

	private void build(String op, String name, String originalValue) {

		switch (op) {

		case OP_EQ:

			srcs.add(buildEQ(name));
			values.add(originalValue.trim());

			break;
		case OP_SW:
			break;
		case OP_EW:
			break;
		case OP_C:
			break;

		case OP_EQ_IC:
			break;
		case OP_SW_IC:
			break;
		case OP_EW_IC:
			break;
		case OP_C_IC:
			break;

		case OP_EQ_T:
			break;
		case OP_SW_T:
			break;
		case OP_EW_T:
			break;
		case OP_C_T:
			break;

		case OP_EQ_ICT:
			break;
		case OP_SW_ICT:

			srcs.add(ilikeTraslate(name));
			values.add(originalValue.trim() + "%");

			break;
		case OP_EW_ICT:
			break;
		case OP_C_ICT:
			break;

		// ------------------

		case OP_EQ_A:
			break;
		case OP_SW_A:
			break;
		case OP_EW_A:
			break;
		case OP_C_A:
			break;

		case OP_EQ_IC_A:
			break;
		case OP_SW_IC_A:
			break;
		case OP_EW_IC_A:
			break;
		case OP_C_IC_A:
			break;

		case OP_EQ_T_A:
			break;
		case OP_SW_T_A:
			break;
		case OP_EW_T_A:
			break;
		case OP_C_T_A:
			break;

		case OP_EQ_ICT_A:

			break;
		case OP_SW_ICT_A:

			operatorSQL = "AND";

			String[] words = originalValue.trim().split(" ");

			for (String word : words) {
				word = word.trim();
				if (word.length() > 0) {
					srcs.add(ilikeTraslate(name));
					values.add(word + "%");
				}
			}

			break;
		case OP_EW_ICT_A:
			break;
		case OP_C_ICT_A:

			operatorSQL = "AND";

			words = originalValue.trim().split(" ");

			for (String word : words) {
				word = word.trim();
				if (word.length() > 0) {
					srcs.add(ilikeTraslate(name));
					values.add("%" + word + "%");
				}
			}

			break;

		// ------------------

		case OP_EQ_O:
			break;
		case OP_SW_O:
			break;
		case OP_EW_O:
			break;
		case OP_C_O:
			break;

		case OP_EQ_IC_O:
			break;
		case OP_SW_IC_O:
			break;
		case OP_EW_IC_O:
			break;
		case OP_C_IC_O:
			break;

		case OP_EQ_T_O:
			break;
		case OP_SW_T_O:
			break;
		case OP_EW_T_O:
			break;
		case OP_C_T_O:
			break;

		case OP_EQ_ICT_O:
			break;
		case OP_SW_ICT_O:

			operatorSQL = "OR";

			words = originalValue.trim().split(" ");

			for (String word : words) {
				word = word.trim();
				if (word.length() > 0) {
					srcs.add(ilikeTraslate(name));
					values.add(word + "%");
				}
			}

			break;
		case OP_EW_ICT_O:
			break;
		case OP_C_ICT_O:
			break;

		default:
//			srcs.add(buildEQ(name));
//			values.add(originalValue.trim());
			throw new IllegalArgumentException("operator not foud: " + op);
		}
	}

	public String toStringSrcs(int t) {

		String tabs = "";
		for (int i = 0; i < t; i++) {
			tabs += "\t";
		}

		String s = "";

		for (int i = 0; i < this.size(); i++) {

			s += (i == 0 ? "(" : "\n") + tabs + (i == 0 ? "" : operatorSQL + " ") + this.getSrcs().get(i)
					+ (i == this.size() - 1 ? ")" : "");
		}

		return s;
	}

	private String ilikeTraslate(String attName) {
		return "TRANSLATE(" + attName + "" + TRANSLATE + ") ILIKE TRANSLATE(? " + TRANSLATE + ")";
	}

//	private String likeTraslate(String attName) {
//		return "TRANSLATE(" + attName + "" + TRANSLATE + ") ILIKE TRANSLATE(? " + TRANSLATE + ")";
//	}

	private String buildEQ(String attName) {
		return attName + " = ?";
	}

}

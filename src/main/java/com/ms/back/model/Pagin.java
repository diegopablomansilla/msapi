package com.ms.back.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.json.JsonObject;

import com.ms.back.commons.json.JsonArrayWrapper;
import com.ms.back.commons.json.JsonObjectWrapper;
import com.ms.back.commons.model.ObjectModel;

public class Pagin extends ObjectModel {

	private String pageRequest;
	private Integer lastIndexOld;
	private Integer pageSize;
	private Integer cantRows;
	private Integer cantPages;
	private List<Page> pages = new ArrayList<Page>();
	private Page firstPage;
	private Page lastPage;
	private Page thisPage;

	private Integer thisPageSize = 0;
	private Integer thisPageColumns;
	private Object[][] thisPageItems;
	private Integer lastIndex;

	public Pagin() {

	}

	public Pagin(Integer pageSize, Integer cantRows, String pageRequest, Integer lastIndexOld) {
		init(pageSize, cantRows, pageRequest, lastIndexOld);
	}

	private void init(Integer pageSize, Integer cantRows, String pageRequest, Integer lastIndexOld) {

		// --------------------------------------------
		double cantPagesDouble = cantRows / (double) pageSize;
		// --------------------------------------------

		this.pageRequest = pageRequest;
		this.lastIndexOld = lastIndexOld;
		this.pageSize = pageSize;
		this.cantRows = cantRows;
		this.cantPages = (int) Math.ceil(cantPagesDouble);

		int fromIndex = 0;

		for (int pageNumber = 0; pageNumber < this.cantPages; pageNumber++) {
			int toIndex = fromIndex + pageSize - 1;
			pages.add(new Page(pageNumber, fromIndex, toIndex));
			fromIndex = toIndex + 1;
		}

		if (pages.size() > 0) {

			this.firstPage = pages.get(0);
			this.firstPage.setFirstPage();

			this.lastPage = pages.get(pages.size() - 1);
			this.lastPage.setLastPage();

			// --------------------------------------------

			if (pageRequest.equals("FIRST")) {

				this.thisPage = this.firstPage;
				this.thisPage.setThisPage(true);

			} else if (pageRequest.equals("LAST")) {

				this.thisPage = this.lastPage;
				this.thisPage.setThisPage(true);

			} else if (lastIndexOld == null || lastIndexOld <= 0) {

				this.thisPage = this.firstPage;
				this.thisPage.setThisPage(true);

			} else if (pageRequest.equals("NEXT")) {
				fromIndex = lastIndexOld + 1;
				for (Page page : pages) {
					if (fromIndex >= page.getIndexFrom() && fromIndex <= page.getIndexTo()) {

						this.thisPage = page;
						this.thisPage.setThisPage(true);
						break;
					}
				}

				if (this.thisPage == null) {

					this.thisPage = this.lastPage;
					this.thisPage.setThisPage(true);

				}

			} else if (pageRequest.equals("BACK")) {

				int toIndex = lastIndexOld - this.pageSize - 1;

				if (toIndex <= 0) {

					this.thisPage = this.firstPage;
					this.thisPage.setThisPage(true);

				} else {

					for (Page page : pages) {
						if (toIndex >= page.getIndexFrom() && toIndex <= page.getIndexTo()) {
							this.thisPage = page;
							this.thisPage.setThisPage(true);
							break;
						}
					}

				}

				if (this.thisPage == null) {
					this.thisPage = this.lastPage;
					this.thisPage.setThisPage(true);
				}

			}

		}
	}

	public void setItems(Object[][] thisPageItems, Integer thisPageColumns) {
		this.thisPageItems = thisPageItems;
		this.thisPageSize = thisPageItems.length;
		this.thisPageColumns = thisPageColumns;
		this.lastIndex = this.thisPage.getIndexFrom() + thisPageItems.length;

//		Object[][] newItems = new Object[thisPageItems.length][columns + 1];
//
//		for (int i = 0; i < thisPageItems.length; i++) {
//
//			int rowIndex = this.thisPage.getIndexFrom() + i;
//
//			newItems[i][0] = rowIndex;
//
//			for (int j = 0; j < thisPageItems[i].length; j++) {
//				newItems[i][j + 1] = thisPageItems[i][j];
//			}
//
//		}
//
//		this.thisPageItems = newItems;

	}

	public String getPageRequest() {
		return pageRequest;
	}

	public Integer getLastIndexOld() {
		return lastIndexOld;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public Integer getCantRows() {
		return cantRows;
	}

	public Integer getCantPages() {
		return cantPages;
	}

	public List<Page> getPages() {
		return pages;
	}

	public Page getFirstPage() {
		return firstPage;
	}

	public Page getLastPage() {
		return lastPage;
	}

	public Page getThisPage() {
		return thisPage;
	}

	public Integer getThisPageSize() {
		return thisPageSize;
	}

	public Integer getThisPageColumns() {
		return thisPageColumns;
	}

	public Object[][] getThisPageItems() {
		return thisPageItems;
	}

	public Integer getLastIndex() {
		return lastIndex;
	}

	public String toString() {

		String s = "";

		s += "\n" + "[" + pageRequest + "] => PAGE_SIZE=[" + pageSize + "], ROWS=[" + cantRows + "], PAGES=["
				+ cantPages + "], LAST_INDEX_OLD=[" + lastIndexOld + "]";

		s += "\n\n";
		for (Page page : pages) {
			s += "\n\t" + page;
		}

//		s += "\n\n" + "first: " + firstPage;
//		s += "\n" + "last: " + lastPage;
//		s += "\n\n" + "this: " + thisPage;

		if (thisPageItems != null) {
			s += "\n\nPAGE = (" + thisPage.getPageNumber() + ") [" + thisPage.getIndexFrom() + "-"
					+ thisPage.getIndexTo() + "], THIS_PAGE_SIZE=[" + thisPageSize + "], THIS_PAGE_COLUMNS=["
					+ thisPageColumns + "], LAST_INDEX=[" + lastIndex + "]";

			for (Object[] row : thisPageItems) {
				s += "\n" + Arrays.toString(row);
			}
		}

		return s;
	}

	public JsonObject toJson() {

		JsonObjectWrapper j = new JsonObjectWrapper();

//		j.set("args", args);

		j.set("pageRequest", this.getPageRequest());
		j.set("lastIndexOld", this.getLastIndexOld());
		j.set("pageSize", this.getPageSize());
		j.set("cantRows", this.getCantRows());
		j.set("cantPages", this.getCantPages());

		JsonArrayWrapper arrayPages = new JsonArrayWrapper();
		for (Page page : pages) {
			arrayPages.add(page);
		}
		j.set("pages", arrayPages.build());

		j.set("firstPage", this.getFirstPage());
		j.set("lastPage", this.getLastPage());
		j.set("thisPage", this.getThisPage());

		j.set("thisPageSize", this.getThisPageSize());
		j.set("thisPageColumns", this.getThisPageColumns());
		j.set("thisPageColumns", this.getThisPageColumns());
		j.set("lastIndex", this.getLastIndex());

//		JsonArrayWrapper jaItems = new JsonArrayWrapper();
//		jaItems.addTable(thisPageItems);				
//		j.set("thisPageItems", jaItems);	

		j.set("thisPageItems", thisPageItems);

		return j.build();
	}

}

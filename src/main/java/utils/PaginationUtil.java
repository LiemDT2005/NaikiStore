/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
public class PaginationUtil {
     public static final int NUMBER_OF_ITEMS_PER_PAGE = 12;

    public static int getTotalPages(int itemsCount) {
        return (int) Math.ceil((double) itemsCount / NUMBER_OF_ITEMS_PER_PAGE);
    }

    public static int getTotalPages(int itemsCount, int pageSize) {
        return (int) Math.ceil((double) itemsCount / pageSize);
    }

    public static int getOffset(int page, int pageSize) {
        return (page - 1) * pageSize;
    }
}

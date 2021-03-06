package dao;

public class SqlQueryUtils {

	public static String getQuery(String sortColumn, String sortType, String searchString, int pageId, String catValue) {
		
		String returnQuery=null, importantCon="", flaggedCon="", plannedCon="LEFT JOIN", attentionCon="", catCon="";
		
		if(sortColumn.equals("COUNT(category_list)") && !catValue.equals("")) {
			sortType = "DESC";
			sortColumn = "category_list";
			catCon = "AND category_list = '"+catValue+"' ";
		}
		
		if(pageId == 1) {
			importantCon = "AND tasks_table.important_status=1";
		}else if(pageId == 2) {
			flaggedCon = "AND tasks_table.flagged_status=1";
		}else if(pageId == 3) {
			plannedCon = "INNER JOIN";
		}else if(pageId == 4) {
			plannedCon = "INNER JOIN";
			attentionCon = "AND task_dates.task_id IN (SELECT task_dates.task_id FROM task_dates WHERE "+
					 	   "DATEDIFF( CURDATE(), remainder_date)>0 "+
						   "OR DATEDIFF( CURDATE(), due_date)>0)";
		}
		
		try {
			returnQuery = "SELECT  task_id_table.task_id, task_name, description, date_added, task_status, important_status, "+
						  "flagged_status, due_date, repeat_status, remainder_date, "+
						  "COUNT(subtask_list) AS 'subCount', category_list "+
						  "FROM task_id_table INNER JOIN tasks_table ON "+
						  "(task_id_table.user_id = ? AND task_id_table.task_id = tasks_table.task_id AND task_name LIKE"+
						  " '%"+searchString+"%' "
						  +flaggedCon+importantCon+") "
						  +plannedCon+" task_dates ON "+
						  "(task_dates.task_id = task_id_table.task_id "+attentionCon+") "+
						  "LEFT JOIN subtasks_table ON "+
						  "(subtasks_table.task_id = task_id_table.task_id) "+
						  "LEFT JOIN category_table ON "+
						  "(category_table.task_id = task_id_table.task_id "+catCon+") "+
						  "GROUP BY task_id_table.task_id "+
						  "ORDER BY "+sortColumn+" "+sortType+" ,task_name ASC ;";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return returnQuery;
	}
}

/*
 *    Copyright 2009-2014 the original author or authors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.apache.ibatis.logging.jdbc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.logging.Log;

/**
 * Base class for proxies to do logging
 * 
 * @author Clinton Begin
 * @author Eduardo Macarron
 */
public abstract class BaseJdbcLogger {

	protected static final Set<String> SET_METHODS = new HashSet<String>();
	protected static final Set<String> EXECUTE_METHODS = new HashSet<String>();

	private Map<Object, Object> columnMap = new HashMap<Object, Object>();

	private List<Object> columnNames = new ArrayList<Object>();
	private List<Object> columnValues = new ArrayList<Object>();

	protected Log statementLog;
	protected int queryStack;

	/*
	 * Default constructor
	 */
	public BaseJdbcLogger(Log log, int queryStack) {
		this.statementLog = log;
		if (queryStack == 0)
			queryStack = 1;
		this.queryStack = queryStack;
	}

	static {
		SET_METHODS.add("setString");
		SET_METHODS.add("setInt");
		SET_METHODS.add("setByte");
		SET_METHODS.add("setShort");
		SET_METHODS.add("setLong");
		SET_METHODS.add("setDouble");
		SET_METHODS.add("setFloat");
		SET_METHODS.add("setTimestamp");
		SET_METHODS.add("setDate");
		SET_METHODS.add("setTime");
		SET_METHODS.add("setArray");
		SET_METHODS.add("setBigDecimal");
		SET_METHODS.add("setAsciiStream");
		SET_METHODS.add("setBinaryStream");
		SET_METHODS.add("setBlob");
		SET_METHODS.add("setBoolean");
		SET_METHODS.add("setBytes");
		SET_METHODS.add("setCharacterStream");
		SET_METHODS.add("setClob");
		SET_METHODS.add("setObject");
		SET_METHODS.add("setNull");

		EXECUTE_METHODS.add("execute");
		EXECUTE_METHODS.add("executeUpdate");
		EXECUTE_METHODS.add("executeQuery");
		EXECUTE_METHODS.add("addBatch");
	}

	protected void setColumn(Object key, Object value) {
		columnMap.put(key, value);
		columnNames.add(key);
		columnValues.add(value);
	}

	protected Object getColumn(Object key) {
		return columnMap.get(key);
	}

	protected String getParameterValueString() {
		List<Object> typeList = new ArrayList<Object>(columnValues.size());
		for (Object value : columnValues) {
			if (value == null) {
				typeList.add("null");
			} else {
				typeList.add(value + "(" + value.getClass().getSimpleName() + ")");
			}
		}
		final String parameters = typeList.toString();
		return parameters.substring(1, parameters.length() - 1);
	}

	protected int getValueSize() {
		return columnValues.size();
	}

	protected String getValueString() {
		return columnValues.toString();
	}

	protected String getTypeString() {
		List<Object> typeList = new ArrayList<Object>(columnValues.size());
		for (int i = 0; i < columnValues.size(); i++) {
			Object value = columnValues.get(i);
			if (value == null) {
				typeList.add("null");
			} else {
				typeList.add(value.getClass().getSimpleName());
			}
		}
		return typeList.toString();
	}

	protected String getColumnString() {
		return columnNames.toString();
	}

	protected void clearColumnInfo() {
		columnMap.clear();
		columnNames.clear();
		columnValues.clear();
	}

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	protected String removeBreakingWhitespace(String original) {
		if (this instanceof PreparedStatementLogger) {
			String sql = SqlTextUtil.leftTrim(original);

			StringBuffer sb = new StringBuffer();

			Matcher m = Pattern.compile("\\?").matcher(sql);
			int i = 0;
			while (m.find()) {
				String replacement;
				Object value = columnValues.get(i);
				if (value == null) {
					replacement = "null";
				} else {
					if (value instanceof java.lang.Number) {
						replacement = value.toString();
					} else if (value instanceof java.util.Date) {
						replacement = "to_date('" + sdf.format((java.util.Date) value) + "','yyyy-mm-dd hh24:mi:ss')";
					} else {
						replacement = "'" + value.toString().replace("$", "\\$") + "'";
					}
				}

				m.appendReplacement(sb, replacement);
				i++;
			}
			m.appendTail(sb);

			return sb.toString();
		} else {
			return SqlTextUtil.leftTrim(original);
		}
	}

	protected boolean isDebugEnabled() {
		return statementLog.isDebugEnabled();
	}

	protected boolean isTraceEnabled() {
		return statementLog.isTraceEnabled();
	}

	protected void debug(String text, boolean input) {
		if (statementLog.isDebugEnabled()) {
			statementLog.debug(prefix(input) + text);
		}
	}

	protected void trace(String text, boolean input) {
		if (statementLog.isTraceEnabled()) {
			statementLog.trace(prefix(input) + text);
		}
	}

	private String prefix(boolean isInput) {
		char[] buffer = new char[queryStack * 2 + 2];
		Arrays.fill(buffer, '=');
		buffer[queryStack * 2 + 1] = ' ';
		if (isInput) {
			buffer[queryStack * 2] = '>';
		} else {
			buffer[0] = '<';
		}
		return new String(buffer);
	}

}

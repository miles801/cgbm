package com.michael.exceptions;

/**
 * 缺少配置项异常
 *
 * @author Michael
 */
public class ConfigFieldMissException extends ConfigException {
    public ConfigFieldMissException() {
        super();
    }

    public ConfigFieldMissException(String message) {
        super(message);
    }

    public ConfigFieldMissException(String message, Throwable cause) {
        super(message, cause);
    }

    public ConfigFieldMissException(Throwable cause) {
        super(cause);
    }

}

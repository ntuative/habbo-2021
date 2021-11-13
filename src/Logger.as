package
{

    import com.sulake.core.runtime.ILogger;

    import flash.external.ExternalInterface;

    public class Logger
    {

        public static var listener: ILogger;

        public function Logger()
        {
            super();
        }

        public static function log(...rest): void
        {
			if (ExternalInterface.available) {
	            ExternalInterface.call("console.log", rest);
			} else {
				trace(rest);
			}
        }
    }
}


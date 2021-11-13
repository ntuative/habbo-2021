package onBoardingHcUi
{
    import flash.display.Sprite;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.localization.ICoreLocalizationManager;

    public class LocalizedSprite extends Sprite implements ILocalizable 
    {

        private static var _localizationManager:ICoreLocalizationManager;

        protected var _localized:Boolean = false;


        public static function set localizationManager(_arg_1:ICoreLocalizationManager):void
        {
            _localizationManager = _arg_1;
        }

        public static function get localizationManager():ICoreLocalizationManager
        {
            return (_localizationManager);
        }


        public function dispose():void
        {
            var _local_1:String = "";
            if ((this is Button))
            {
                _local_1 = (this as Button).label;
            };
            removeOldLocalization(_local_1);
        }

        public function set localization(_arg_1:String):void
        {
            if ((this is Button))
            {
                (this as Button).localizedText = _arg_1;
            };
        }

        protected function removeOldLocalization(_arg_1:String):void
        {
            if (_localized)
            {
                localizationManager.removeListener(_arg_1.slice(2, _arg_1.indexOf("}")), this);
                _localized = false;
            };
        }

        protected function checkLocalization(_arg_1:String):void
        {
            if (((((localizationManager) && (_arg_1)) && (_arg_1.charAt(0) == "$")) && (_arg_1.charAt(1) == "{")))
            {
                _localized = true;
                localizationManager.registerListener(_arg_1.slice(2, _arg_1.indexOf("}")), this);
            };
        }


    }
}
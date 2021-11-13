package com.sulake.habbo.localization
{
    import com.sulake.core.localization.CoreLocalizationManager;
    import flash.utils.Dictionary;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.localization.BadgeBaseAndLevel;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class HabboLocalizationManager extends CoreLocalizationManager implements IHabboLocalizationManager 
    {

        private var _SafeStr_2798:Boolean;
        private var _skipExternals:Boolean = false;
        private var _SafeStr_2799:Dictionary = new Dictionary();
        private var _romanNumerals:Array = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX"];

        public function HabboLocalizationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            _skipExternals = ((_arg_2 & 0x10000000) > 0);
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override protected function initComponent():void
        {
            super.initComponent();
            configureLocalizationLocations();
            if (_skipExternals)
            {
                events.dispatchEvent(new Event("complete"));
            }
            else
            {
                context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED", onAuthenticated);
            };
        }

        private function onAuthenticated(_arg_1:Event):void
        {
            requestLocalizationInit();
        }

        public function loadDefaultEmbedLocalizations(_arg_1:String, _arg_2:Boolean=true):Boolean
        {
            var _local_3:String = ("default_localizations_" + _arg_1);
            var _local_4:IAsset = assets.getAssetByName(_local_3);
            if ((((!(_local_4)) && (!(_arg_1 == "en"))) && (_arg_2)))
            {
                Logger.log((("Could not load default localizations " + _local_3) + " : Trying with default_localizations_en..."));
                return (loadDefaultEmbedLocalizations("en", false));
            };
            if (_local_4)
            {
                parseLocalizationData((_local_4.content as String));
                return (true);
            };
            Logger.log(("Could not load " + _local_3));
            return (false);
        }

        public function getLocalizationWithParams(_arg_1:String, _arg_2:String="", ... _args):String
        {
            var _local_4:int;
            var _local_5:int;
            if (((!(_args == null)) && (_args.length > 0)))
            {
                _local_4 = int((_args.length / 2));
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    registerParameter(_arg_1, _args[(_local_5 * 2)], _args[((_local_5 * 2) + 1)]);
                    _local_5++;
                };
            };
            return (this.getLocalization(_arg_1, _arg_2));
        }

        public function getLocalizationWithParamMap(_arg_1:String, _arg_2:String="", _arg_3:Map=null):String
        {
            if (_arg_3 != null)
            {
                for (var _local_4:String in _arg_3)
                {
                    registerParameter(_arg_1, _local_4, _arg_3.getValue(_local_4));
                };
            };
            return (this.getLocalization(_arg_1, _arg_2));
        }

        public function getExternalVariablesUrl():String
        {
            return (super.getGameDataResources().getExternalVariablesUrl());
        }

        public function getExternalVariablesHash():String
        {
            return (super.getGameDataResources().getExternalVariablesHash());
        }

        override public function getActiveEnvironmentId():String
        {
            return (super.getActiveEnvironmentId());
        }

        override public function getLocalization(_arg_1:String, _arg_2:String=""):String
        {
            var _local_3:String = super.getLocalization(_arg_1, _arg_2);
            return (interpolate(_local_3));
        }

        public function getAchievementName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_4:String = getExistingKey([("badge_name_al_" + _arg_1), ("badge_name_al_" + _local_2.base), ("badge_name_" + _arg_1), ("badge_name_" + _local_2.base)]);
            this.registerParameter(_local_4, "roman", getRomanNumeral(_local_2.level));
            var _local_3:String = this.getLocalization(_local_4);
            return ((_local_3 != null) ? _local_3 : "");
        }

        public function getAchievementDesc(_arg_1:String, _arg_2:int):String
        {
            var _local_3:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_4:String = getExistingKey([("badge_desc_al_" + _arg_1), ("badge_desc_al_" + _local_3.base), ("badge_desc_" + _arg_1), ("badge_desc_" + _local_3.base)]);
            this.registerParameter(_local_4, "limit", ("" + _arg_2));
            this.registerParameter(_local_4, "roman", getRomanNumeral(_local_3.level));
            return (this.getLocalization(_local_4));
        }

        public function getAchievementInstruction(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_4:String = getExistingKey([("badge_instruction_" + _local_2.base)]);
            this.registerParameter(_local_4, "limit", ("" + getBadgePointLimit(_arg_1)));
            var _local_3:String = this.getLocalization(_local_4);
            return ((_local_3 != null) ? _local_3 : "");
        }

        public function getBadgeBaseName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            return (_local_2.base);
        }

        public function getBadgeName(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_3:String = fixBadLocalization(getExistingKey([("badge_name_" + _arg_1), ("badge_name_" + _local_2.base)]));
            this.registerParameter(_local_3, "roman", getRomanNumeral(_local_2.level));
            return (this.getLocalization(_local_3));
        }

        public function getBadgeDesc(_arg_1:String):String
        {
            var _local_3:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            var _local_4:String = fixBadLocalization(getExistingKey([("badge_desc_" + _arg_1), ("badge_desc_" + _local_3.base)]));
            this.registerParameter(_local_4, "limit", ("" + getBadgePointLimit(_arg_1)));
            this.registerParameter(_local_4, "roman", getRomanNumeral(_local_3.level));
            var _local_2:String = this.getLocalization(_local_4);
            return ((_local_4 == _local_2) ? "" : _local_2);
        }

        private function fixBadLocalization(_arg_1:String):String
        {
            var _local_2:String = _arg_1.replace("${", "$");
            _local_2 = _local_2.replace("{", "$");
            return (_local_2.replace("}", "$"));
        }

        public function getPreviousLevelBadgeId(_arg_1:String):String
        {
            var _local_2:BadgeBaseAndLevel = new BadgeBaseAndLevel(_arg_1);
            _local_2.level--;
            return (_local_2.badgeId);
        }

        public function setBadgePointLimit(_arg_1:String, _arg_2:int):void
        {
            _SafeStr_2799[_arg_1] = _arg_2;
        }

        private function configureLocalizationLocations():void
        {
            var _local_3:String;
            var _local_2:String;
            var _local_1:String;
            var _local_5:String;
            var _local_4:int = 1;
            while (propertyExists(("localization." + _local_4)))
            {
                _local_3 = getProperty(("localization." + _local_4));
                _local_2 = getProperty((("localization." + _local_4) + ".code"));
                _local_1 = getProperty((("localization." + _local_4) + ".name"));
                _local_5 = getProperty((("localization." + _local_4) + ".url"));
                super.registerLocalizationDefinition(_local_3, _local_1, _local_5, _local_2);
                _local_4++;
            };
        }

        public function requestLocalizationInit():void
        {
            _SafeStr_2798 = true;
            events.addEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED", onLocalizationLoaded);
            super.loadLocalizationFromURL(getProperty("gamedata.hashes.url"), getProperty("environment.id"));
        }

        private function getBadgePointLimit(_arg_1:String):int
        {
            return (_SafeStr_2799[_arg_1]);
        }

        private function getExistingKey(_arg_1:Array):String
        {
            var _local_2:String;
            for each (var _local_3:String in _arg_1)
            {
                _local_2 = this.getLocalization(_local_3);
                if (_local_2 != "")
                {
                    return (_local_3);
                };
            };
            return (_arg_1[0]);
        }

        private function getRomanNumeral(_arg_1:int):String
        {
            return (_romanNumerals[Math.max(0, (_arg_1 - 1))]);
        }

        private function parseDevelopmentLocalizations():void
        {
        }

        override protected function onLocalizationFailed(_arg_1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("external_texts download error " + _arg_1.status));
            super.onLocalizationFailed(_arg_1);
        }

        private function onLocalizationLoaded(_arg_1:Event):void
        {
            events.removeEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED", onLocalizationLoaded);
            localizationsReady();
        }

        private function localizationsReady():void
        {
            events.dispatchEvent(new Event("complete"));
        }


    }
}


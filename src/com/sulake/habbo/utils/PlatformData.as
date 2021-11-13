package com.sulake.habbo.utils
{
    import com.sulake.habbo.utils.air.INativeApplicationProxy;
    import flash.system.Capabilities;

    public class PlatformData 
    {

        public static const DEVICE_TYPE_PHONE:int = 0;
        public static const DEVICE_TYPE_TABLET:int = 1;
        public static const DEVICE_TYPE_DESKTOP:int = 2;
        public static const PLATFORM_DESKTOP:int = -1;
        public static const PLATFORM_ANDROID:int = 0;
        public static const PLATFORM_IOS:int = 1;
        private static const MAX_DYNAMIC_TEXTURE_DIMENSION_SD:int = 0x0200;
        private static const MAX_DYNAMIC_TEXTURE_DIMENSION_HD:int = 0x0800;
        private static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
        private static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

        private static var _scale:Number;
        private static var _SafeStr_4366:Number;
        private static var _SafeStr_4367:int = -1;
        private static var _SafeStr_4368:int = -1;
        private static var _isLowMemoryDevice:Boolean;
        private static var _nativeApplicationProxy:INativeApplicationProxy;
        public static var PHONE_SCALE_FACTOR:Number = 0.65;


        public static function init():void
        {
            initOs();
            initScale();
            initDeviceType();
            initLowMem();
        }

        public static function set nativeApplicationProxy(_arg_1:INativeApplicationProxy):void
        {
            _nativeApplicationProxy = _arg_1;
        }

        public static function get nativeApplicationProxy():INativeApplicationProxy
        {
            return (_nativeApplicationProxy);
        }

        public static function get isDeviceHD():Boolean
        {
            if (Math.max(Capabilities.screenResolutionX, Capabilities.screenResolutionY) < 1600)
            {
                return (false);
            };
            return (scale > 0.75);
        }

        public static function get isSmallScreenDevice():Boolean
        {
            return ((!(isDeviceHD)) || (isPhone()));
        }

        public static function get isWideScreenDevice():Boolean
        {
            return (false);
        }

        public static function get requiresWideMargins():Boolean
        {
            return (isiPhoneX);
        }

        public static function get isiPhoneX():Boolean
        {
            return (false);
        }

        public static function get isLowMemoryDevice():Boolean
        {
            return (_isLowMemoryDevice);
        }

        public static function smartScaleFactor():int
        {
            return ((isDeviceHD) ? 2 : 1);
        }

        public static function get scale():Number
        {
            return (_scale);
        }

        public static function evenScale(_arg_1:int):int
        {
            _arg_1 = (_arg_1 * scale);
            return ((_arg_1 | 0x01) - 1);
        }

        public static function get maxDynamicTextureDimension():int
        {
            return ((isLowMemoryDevice) ? 0x0200 : 0x0800);
        }

        public static function isAndroid():Boolean
        {
            return (platformId() == 0);
        }

        public static function isIos():Boolean
        {
            return (platformId() == 1);
        }

        public static function isDesktop():Boolean
        {
            return (platformId() == -1);
        }

        public static function isPhone():Boolean
        {
            return (_SafeStr_4367 == 0);
        }

        public static function platformId():int
        {
            return (_SafeStr_4368);
        }

        public static function platformString():String
        {
            switch (_SafeStr_4368)
            {
                case 1:
                    return ("ios");
                case 0:
                    return ("android");
                case -1:
                    return ("desktop");
                default:
                    return ("unknown");
            };
        }

        public static function deviceType():int
        {
            return (_SafeStr_4367);
        }

        private static function initOs():void
        {
            var _local_1:String = Capabilities.version.toLowerCase();
            if (_local_1.indexOf("and") > -1)
            {
                _SafeStr_4368 = 0;
                return;
            };
            if (_local_1.indexOf("ios") > -1)
            {
                _SafeStr_4368 = 1;
                return;
            };
            _SafeStr_4368 = -1;
        }

        public static function initScale():void
        {
        }

        private static function initDeviceType():void
        {
            var _local_1:String = Capabilities.version.toLowerCase();
            if ((((_local_1.indexOf("win") > -1) || (_local_1.indexOf("mac") > -1)) || (_local_1.indexOf("lnx") > -1)))
            {
                _SafeStr_4367 = 2;
                return;
            };
            _SafeStr_4367 = 0;
        }

        private static function initLowMem():void
        {
            var _local_1:Array;
            var _local_2:String;
            if (_SafeStr_4368 == 1)
            {
                _local_1 = ["iPhone4,1", "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad2,5", "iPad2,6", "iPad2,7", "iPod5,1"];
                _local_2 = Capabilities.os;
                for each (var _local_3:String in _local_1)
                {
                    if (_local_2.indexOf(_local_3) != -1)
                    {
                        _isLowMemoryDevice = true;
                        return;
                    };
                };
                _isLowMemoryDevice = false;
            }
            else
            {
                if (_SafeStr_4368 != 0)
                {
                };
            };
        }

        private static function isLowMemProfile(_arg_1:String):Boolean
        {
            var _local_2:Array = ["baseline", "baselineConstrained"];
            return (!(_local_2.indexOf(_arg_1) == -1));
        }

        public static function isIOSSimulator():Boolean
        {
            return ((isIos()) && (!(Capabilities.os.indexOf("x86") == -1)));
        }

        public static function getDeviceStringForLogging():String
        {
            var _local_1:String;
            if (isAndroid())
            {
                _local_1 = (_local_1 + "ANDROID");
            }
            else
            {
                if (isIos())
                {
                    _local_1 = (_local_1 + "IOS");
                }
                else
                {
                    _local_1 = (_local_1 + "FLASH");
                };
            };
            _local_1 = (_local_1 + ".");
            if (isDesktop())
            {
                _local_1 = (_local_1 + "UNKNOWN");
            }
            else
            {
                if (isPhone())
                {
                    _local_1 = (_local_1 + "PHONE");
                }
                else
                {
                    _local_1 = (_local_1 + "TABLET");
                };
            };
            return (_local_1);
        }


    }
}


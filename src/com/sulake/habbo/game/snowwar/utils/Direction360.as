package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.runtime.IDisposable;

    public class Direction360 implements IDisposable 
    {

        private static const _SafeStr_2567:Number = 1;
        public static const N:int = 0;
        public static const NE:int = 45;
        public static const E:int = 90;
        public static const SE:int = 135;
        public static const S:int = 180;
        public static const SW:int = 225;
        public static const W:int = 270;
        public static const NW:int = 315;

        private static var _SafeStr_2568:Array = [[0, 4, 8, 13, 17, 22, 26, 31, 35, 40, 44, 48, 53, 57, 61, 66, 70, 74, 79, 83, 87, 91, 95, 100, 104, 108, 112, 116, 120, 124, 127, 131, 135, 139, 143, 146, 150, 154, 157, 161, 164, 167, 171, 174, 177, 181, 184, 187, 190, 193, 196, 198, 201, 204, 207, 209, 212, 214, 217, 219, 221, 223, 226, 228, 230, 232, 233, 235, 237, 238, 240, 242, 243, 244, 246, 247, 248, 249, 250, 251, 252, 252, 253, 254, 254, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0100, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 254, 254, 253, 252, 252, 251, 250, 249, 248, 247, 246, 244, 243, 242, 240, 238, 237, 235, 233, 232, 230, 228, 226, 223, 221, 219, 217, 214, 212, 209, 207, 204, 201, 198, 196, 193, 190, 187, 184, 181, 177, 174, 171, 167, 164, 161, 157, 154, 150, 146, 143, 139, 135, 131, 127, 124, 120, 116, 112, 108, 104, 100, 95, 91, 87, 83, 79, 74, 70, 66, 61, 57, 53, 48, 44, 40, 35, 31, 26, 22, 17, 13, 8, 4, 0, -4, -8, -13, -17, -22, -26, -31, -35, -40, -44, -48, -53, -57, -61, -66, -70, -74, -79, -83, -87, -91, -95, -100, -104, -108, -112, -116, -120, -124, -128, -131, -135, -139, -143, -146, -150, -154, -157, -161, -164, -167, -171, -174, -177, -181, -184, -187, -190, -193, -196, -198, -201, -204, -207, -209, -212, -214, -217, -219, -221, -223, -226, -228, -230, -232, -233, -235, -237, -238, -240, -242, -243, -244, -246, -247, -248, -249, -250, -251, -252, -252, -253, -254, -254, -255, -255, -255, -255, -255, -256, -255, -255, -255, -255, -255, -254, -254, -253, -252, -252, -251, -250, -249, -248, -247, -246, -244, -243, -242, -240, -238, -237, -235, -233, -232, -230, -228, -226, -223, -221, -219, -217, -214, -212, -209, -207, -204, -201, -198, -196, -193, -190, -187, -184, -181, -177, -174, -171, -167, -164, -161, -157, -154, -150, -146, -143, -139, -135, -131, -128, -124, -120, -116, -112, -108, -104, -100, -95, -91, -87, -83, -79, -74, -70, -66, -61, -57, -53, -48, -44, -40, -35, -31, -26, -22, -17, -13, -8, -4], [-256, -255, -255, -255, -255, -255, -254, -254, -253, -252, -252, -251, -250, -249, -248, -247, -246, -244, -243, -242, -240, -238, -237, -235, -233, -232, -230, -228, -226, -223, -221, -219, -217, -214, -212, -209, -207, -204, -201, -198, -196, -193, -190, -187, -184, -181, -177, -174, -171, -167, -164, -161, -157, -154, -150, -146, -143, -139, -135, -131, -128, -124, -120, -116, -112, -108, -104, -100, -95, -91, -87, -83, -79, -74, -70, -66, -61, -57, -53, -48, -44, -40, -35, -31, -26, -22, -17, -13, -8, -4, 0, 4, 8, 13, 17, 22, 26, 31, 35, 40, 44, 48, 53, 57, 61, 66, 70, 74, 79, 83, 87, 91, 95, 100, 104, 108, 112, 116, 120, 124, 127, 131, 135, 139, 143, 146, 150, 154, 157, 161, 164, 167, 171, 174, 177, 181, 184, 187, 190, 193, 196, 198, 201, 204, 207, 209, 212, 214, 217, 219, 221, 223, 226, 228, 230, 232, 233, 235, 237, 238, 240, 242, 243, 244, 246, 247, 248, 249, 250, 251, 252, 252, 253, 254, 254, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0100, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 254, 254, 253, 252, 252, 251, 250, 249, 248, 247, 246, 244, 243, 242, 240, 238, 237, 235, 233, 232, 230, 228, 226, 223, 221, 219, 217, 214, 212, 209, 207, 204, 201, 198, 196, 193, 190, 187, 184, 181, 177, 174, 171, 167, 164, 161, 157, 154, 150, 146, 143, 139, 135, 131, 128, 124, 120, 116, 112, 108, 104, 100, 95, 91, 87, 83, 79, 74, 70, 66, 61, 57, 53, 48, 44, 40, 35, 31, 26, 22, 17, 13, 8, 4, 0, -4, -8, -13, -17, -22, -26, -31, -35, -40, -44, -48, -53, -57, -61, -66, -70, -74, -79, -83, -87, -91, -95, -100, -104, -108, -112, -116, -120, -124, -128, -131, -135, -139, -143, -146, -150, -154, -157, -161, -164, -167, -171, -174, -177, -181, -184, -187, -190, -193, -196, -198, -201, -204, -207, -209, -212, -214, -217, -219, -221, -223, -226, -228, -230, -232, -233, -235, -237, -238, -240, -242, -243, -244, -246, -247, -248, -249, -250, -251, -252, -252, -253, -254, -254, -255, -255, -255, -255, -255]];
        private static var componentToAngleArray:Array = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11, 11, 11, 11, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 25, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 30, 30, 30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 32, 32, 32, 32, 32, 32, 33, 33, 33, 33, 33, 33, 34, 34, 34, 34, 34, 34, 34, 35, 35, 35, 35, 35, 35, 36, 36, 36, 36, 36, 36, 36, 37, 37, 37, 37, 37, 37, 37, 38, 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39, 39, 39, 39, 40, 40, 40, 40, 40, 40, 40, 41, 41, 41, 41, 41, 41, 41, 41, 42, 42, 42, 42, 42, 42, 42, 42, 43, 43, 43, 43, 43, 43, 43, 43, 44, 44, 44, 44, 44, 44, 44, 44, 44, 45, 45, 45, 45, 45];

        private var _SafeStr_2569:int = 0;
        private var _disposed:Boolean = false;

        public function Direction360(_arg_1:int)
        {
            _SafeStr_2569 = _arg_1;
        }

        public static function validateDirection360Value(_arg_1:int):int
        {
            if (_arg_1 > 359)
            {
                _arg_1 = (_arg_1 % 360);
            }
            else
            {
                if (_arg_1 < 0)
                {
                    _arg_1 = (360 + (_arg_1 % 360));
                };
            };
            return (_arg_1);
        }

        public static function direction360ValueToDirection8(_arg_1:int):Direction8
        {
            return (Direction8.getDirection8(Direction8.validateDirection8Value((_SafeStr_206.javaDiv((validateDirection360Value((_arg_1 - 22)) / 45)) + 1))));
        }

        public static function direction8ToDirection360Value(_arg_1:Direction8):int
        {
            switch (_arg_1.intValue())
            {
                case 0:
                    return (0);
                case 1:
                    return (45);
                case 2:
                    return (90);
                case 3:
                    return (135);
                case 4:
                    return (180);
                case 5:
                    return (225);
                case 6:
                    return (270);
                case 7:
                    return (315);
                default:
                    return (-1);
            };
        }

        public static function getBaseVectorXComponent(_arg_1:int):int
        {
            _arg_1 = validateDirection360Value(_arg_1);
            return (_SafeStr_2568[0][_arg_1]);
        }

        public static function getBaseVectorYComponent(_arg_1:int):int
        {
            _arg_1 = validateDirection360Value(_arg_1);
            return (_SafeStr_2568[1][_arg_1]);
        }

        public static function getAngleFromComponents(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (absoluteValue(_arg_1) <= absoluteValue(_arg_2))
            {
                if (_arg_2 == 0)
                {
                    _arg_2 = 1;
                };
                _arg_1 = (_arg_1 * 0x0100);
                _local_3 = int(_SafeStr_206.javaDiv((_arg_1 / _arg_2)));
                if (_local_3 < 0)
                {
                    _local_3 = -(_local_3);
                };
                if (_local_3 > 0xFF)
                {
                    _local_3 = 0xFF;
                };
                if (_arg_2 < 0)
                {
                    if (_arg_1 > 0)
                    {
                        return (componentToAngleArray[_local_3]);
                    };
                    return (360 - componentToAngleArray[_local_3]);
                };
                if (_arg_1 > 0)
                {
                    return (180 - componentToAngleArray[_local_3]);
                };
                return (180 + componentToAngleArray[_local_3]);
            };
            if (_arg_1 == 0)
            {
                _arg_1 = 1;
            };
            _arg_2 = (_arg_2 * 0x0100);
            _local_3 = int(_SafeStr_206.javaDiv((_arg_2 / _arg_1)));
            if (_local_3 < 0)
            {
                _local_3 = -(_local_3);
            };
            if (_local_3 > 0xFF)
            {
                _local_3 = 0xFF;
            };
            if (_arg_2 < 0)
            {
                if (_arg_1 > 0)
                {
                    return (90 - componentToAngleArray[_local_3]);
                };
                return (270 + componentToAngleArray[_local_3]);
            };
            if (_arg_1 > 0)
            {
                return (90 + componentToAngleArray[_local_3]);
            };
            return (270 - componentToAngleArray[_local_3]);
        }

        public static function absoluteValue(_arg_1:int):int
        {
            if (_arg_1 < 0)
            {
                return (-(_arg_1));
            };
            return (_arg_1);
        }

        private static function getAngleAtan(_arg_1:int, _arg_2:int):int
        {
            return (Math.atan2(_arg_1, ((_arg_2 * 57.295) + 0.5)));
        }


        public function dispose():void
        {
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function intValue():int
        {
            return (_SafeStr_2569);
        }

        public function setIntValue(_arg_1:int):void
        {
            _SafeStr_2569 = validateDirection360Value(_arg_1);
        }

        public function rotateDirection(_arg_1:int):void
        {
            _SafeStr_2569 = (_SafeStr_2569 + _arg_1);
            _SafeStr_2569 = validateDirection360Value(_SafeStr_2569);
        }

        public function toString():String
        {
            return (("[" + _SafeStr_2569) + "]");
        }

        public function direction8Value():Direction8
        {
            return (direction360ValueToDirection8(_SafeStr_2569));
        }

        public function getBaseVectorXComponent():int
        {
            return (_SafeStr_2568[0][_SafeStr_2569]);
        }

        public function getBaseVectorYComponent():int
        {
            return (_SafeStr_2568[1][_SafeStr_2569]);
        }


    }
}


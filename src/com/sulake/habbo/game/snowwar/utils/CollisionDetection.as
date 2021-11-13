package com.sulake.habbo.game.snowwar.utils
{
    public class CollisionDetection 
    {

        public static const BOUNDING_TYPE_NONE:int = 0;
        public static const BOUNDING_TYPE_POINT:int = 1;
        public static const BOUNDING_TYPE_CIRCLE:int = 2;
        public static const BOUNDING_TYPE_BOX:int = 3;
        public static const BOUNDING_TYPE_TRIPLE_CIRCLE:int = 4;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_FIRST_RADIUS:int = 0;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_SECOND_RADIUS:int = 1;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_THIRD_RADIUS:int = 2;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_FIRST_OFFSET:int = 3;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_THIRD_OFFSET:int = 4;
        public static const BOUNDING_DATA_TRIPLE_CIRCLE_LARGEST_DISTANCE:int = 5;


        public static function testForObjectToObjectCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            if (_arg_2 == _arg_1)
            {
                return (false);
            };
            switch (_arg_2.boundingType)
            {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    switch (_arg_1.boundingType)
                    {
                        case 1:
                            if (testPointToCircleCollision(_arg_1, _arg_2))
                            {
                                return (true);
                            };
                            break;
                        case 2:
                            if (testCircleToCircleCollision(_arg_1, _arg_2))
                            {
                                return (true);
                            };
                            break;
                        case 4:
                            if (testCircleToTripleCircleCollision(_arg_2, _arg_1))
                            {
                                return (true);
                            };
                        default:
                    };
                    break;
                case 4:
                    switch (_arg_1.boundingType)
                    {
                        case 1:
                            if (testPointToTripleCircleCollision(_arg_1, _arg_2))
                            {
                                return (true);
                            };
                            break;
                        case 2:
                            if (testCircleToTripleCircleCollision(_arg_1, _arg_2))
                            {
                                return (true);
                            };
                            break;
                        case 4:
                            if (testTripleCircleToTripleCircleCollision(_arg_1, _arg_2))
                            {
                                return (true);
                            };
                        default:
                    };
                    break;
                case 3:
                    if (_arg_1.boundingType == 1)
                    {
                        if (testPointToBoxCollision(_arg_1, _arg_2))
                        {
                            return (true);
                        };
                    };
                default:
            };
            return (false);
        }

        private static function testPointToCircleCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            return (_arg_1.location3D.isInDistance(_arg_2.location3D, _arg_2.boundingData[0]));
        }

        private static function testPointToBoxCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            var _local_3:Array = _arg_2.boundingData;
            if (((((_arg_1.location3D.x > (_arg_2.location3D.x + _local_3[0])) && (_arg_1.location3D.x < (_arg_2.location3D.x + _local_3[2]))) && (_arg_1.location3D.y > (_arg_2.location3D.y + _local_3[1]))) && (_arg_1.location3D.y < (_arg_2.location3D.y + _local_3[3]))))
            {
                return (true);
            };
            return (false);
        }

        private static function testCircleToCircleCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            return (_arg_1.location3D.isInDistance(_arg_2.location3D, (_arg_1.boundingData[0] + _arg_2.boundingData[0])));
        }

        private static function testPointToTripleCircleCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            var _local_8:int = absoluteValue((_arg_2.location3D.x - _arg_1.location3D.x));
            if (_local_8 > _arg_2.boundingData[5])
            {
                return (false);
            };
            var _local_7:int = absoluteValue((_arg_2.location3D.y - _arg_1.location3D.y));
            if (_local_7 > _arg_2.boundingData[5])
            {
                return (false);
            };
            var _local_5:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            var _local_6:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_5, _local_6, _arg_1.location3D.x, _arg_1.location3D.y, _arg_2.boundingData[0]))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_arg_2.location3D.x, _arg_2.location3D.y, _arg_1.location3D.x, _arg_1.location3D.y, _arg_2.boundingData[1]))
            {
                return (true);
            };
            var _local_3:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            var _local_4:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_3, _local_4, _arg_1.location3D.x, _arg_1.location3D.y, _arg_2.boundingData[2]))
            {
                return (true);
            };
            return (false);
        }

        private static function testCircleToTripleCircleCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            var _local_8:int = absoluteValue((_arg_2.location3D.x - _arg_1.location3D.x));
            if (_local_8 > (_arg_1.boundingData[0] + _arg_2.boundingData[5]))
            {
                return (false);
            };
            var _local_7:int = absoluteValue((_arg_2.location3D.y - _arg_1.location3D.y));
            if (_local_7 > (_arg_1.boundingData[0] + _arg_2.boundingData[5]))
            {
                return (false);
            };
            var _local_5:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            var _local_6:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_5, _local_6, _arg_1.location3D.x, _arg_1.location3D.y, (_arg_2.boundingData[0] + _arg_1.boundingData[0])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_arg_2.location3D.x, _arg_2.location3D.y, _arg_1.location3D.x, _arg_1.location3D.y, (_arg_2.boundingData[1] + _arg_1.boundingData[0])))
            {
                return (true);
            };
            var _local_3:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            var _local_4:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_3, _local_4, _arg_1.location3D.x, _arg_1.location3D.y, (_arg_2.boundingData[2] + _arg_1.boundingData[0])))
            {
                return (true);
            };
            return (false);
        }

        private static function testTripleCircleToTripleCircleCollision(_arg_1:ICollidable, _arg_2:ICollidable):Boolean
        {
            var _local_11:int = absoluteValue((_arg_2.location3D.x - _arg_1.location3D.x));
            if (_local_11 > (_arg_1.boundingData[5] + _arg_2.boundingData[5]))
            {
                return (false);
            };
            var _local_10:int = absoluteValue((_arg_2.location3D.y - _arg_1.location3D.y));
            if (_local_10 > (_arg_1.boundingData[5] + _arg_2.boundingData[5]))
            {
                return (false);
            };
            var _local_5:int = int((_arg_1.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_1.direction360.intValue()) * _arg_1.boundingData[3]) / 0x0100))));
            var _local_3:int = int((_arg_1.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_1.direction360.intValue()) * _arg_1.boundingData[3]) / 0x0100))));
            var _local_12:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            var _local_6:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[3]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_5, _local_3, _local_12, _local_6, (_arg_1.boundingData[0] + _arg_2.boundingData[0])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_local_5, _local_3, _arg_2.location3D.x, _arg_2.location3D.y, (_arg_1.boundingData[0] + _arg_2.boundingData[1])))
            {
                return (true);
            };
            var _local_4:int = int((_arg_2.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            var _local_8:int = int((_arg_2.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_2.direction360.intValue()) * _arg_2.boundingData[4]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_5, _local_3, _local_4, _local_8, (_arg_1.boundingData[0] + _arg_2.boundingData[2])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_arg_1.location3D.x, _arg_1.location3D.y, _local_12, _local_6, (_arg_1.boundingData[1] + _arg_2.boundingData[0])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_arg_1.location3D.x, _arg_1.location3D.y, _arg_2.location3D.x, _arg_2.location3D.y, (_arg_1.boundingData[1] + _arg_2.boundingData[1])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_arg_1.location3D.x, _arg_1.location3D.y, _local_4, _local_8, (_arg_1.boundingData[1] + _arg_2.boundingData[2])))
            {
                return (true);
            };
            var _local_9:int = int((_arg_1.location3D.x + _SafeStr_206.javaDiv(((Direction360.getBaseVectorXComponent(_arg_1.direction360.intValue()) * _arg_1.boundingData[4]) / 0x0100))));
            var _local_7:int = int((_arg_1.location3D.y + _SafeStr_206.javaDiv(((Direction360.getBaseVectorYComponent(_arg_1.direction360.intValue()) * _arg_1.boundingData[4]) / 0x0100))));
            if (Location3D.isInDistanceStatic(_local_9, _local_7, _local_12, _local_6, (_arg_1.boundingData[2] + _arg_2.boundingData[0])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_local_9, _local_7, _arg_2.location3D.x, _arg_2.location3D.y, (_arg_1.boundingData[2] + _arg_2.boundingData[1])))
            {
                return (true);
            };
            if (Location3D.isInDistanceStatic(_local_9, _local_7, _local_4, _local_8, (_arg_1.boundingData[2] + _arg_2.boundingData[2])))
            {
                return (true);
            };
            return (false);
        }

        protected static function absoluteValue(_arg_1:int):int
        {
            if (_arg_1 < 0)
            {
                return (-(_arg_1));
            };
            return (_arg_1);
        }


    }
}


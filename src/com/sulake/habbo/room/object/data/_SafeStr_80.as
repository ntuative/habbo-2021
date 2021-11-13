package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;

    public class _SafeStr_80 
    {


        public static function getStuffDataWrapperForType(_arg_1:int):IStuffData
        {
            var _local_3:int = (_arg_1 & 0xFF);
            var _local_2:IStuffData;
            switch (_local_3)
            {
                case 0:
                    _local_2 = (new LegacyStuffData() as IStuffData);
                    break;
                case 1:
                    _local_2 = (new MapStuffData() as IStuffData);
                    break;
                case 2:
                    _local_2 = (new StringArrayStuffData() as IStuffData);
                    break;
                case 3:
                    _local_2 = (new VoteResultStuffData() as IStuffData);
                    break;
                case 4:
                    _local_2 = (new EmptyStuffData() as IStuffData);
                    break;
                case 5:
                    _local_2 = (new IntArrayStuffData() as IStuffData);
                    break;
                case 6:
                    _local_2 = (new HighScoreStuffData() as IStuffData);
                    break;
                case 7:
                    _local_2 = (new CrackableStuffData() as IStuffData);
                default:
            };
            if (_local_2 != null)
            {
                _local_2.flags = (_arg_1 & 0xFF00);
            };
            return (_local_2);
        }


    }
}


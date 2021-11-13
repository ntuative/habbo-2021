package com.sulake.habbo.communication.messages.incoming.users
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.ColorConverter;

        public class GuildEditorData 
    {

        private var _baseParts:Vector.<BadgePartData> = new Vector.<BadgePartData>();
        private var _layerParts:Vector.<BadgePartData> = new Vector.<BadgePartData>();
        private var _badgeColors:Vector.<GuildColorData> = new Vector.<GuildColorData>();
        private var _guildPrimaryColors:Vector.<GuildColorData> = new Vector.<GuildColorData>();
        private var _guildSecondaryColors:Vector.<GuildColorData> = new Vector.<GuildColorData>();

        public function GuildEditorData(_arg_1:IMessageDataWrapper=null)
        {
            var _local_3:int;
            var _local_2:int;
            super();
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _baseParts.push(new BadgePartData(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _layerParts.push(new BadgePartData(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _badgeColors.push(new GuildColorData(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _guildPrimaryColors.push(new GuildColorData(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _guildSecondaryColors.push(new GuildColorData(_arg_1));
                _local_3++;
            };
        }

        public function get baseParts():Vector.<BadgePartData>
        {
            return (_baseParts);
        }

        public function get layerParts():Vector.<BadgePartData>
        {
            return (_layerParts);
        }

        public function get badgeColors():Vector.<GuildColorData>
        {
            return (_badgeColors);
        }

        public function get guildPrimaryColors():Vector.<GuildColorData>
        {
            return (_guildPrimaryColors);
        }

        public function get guildSecondaryColors():Vector.<GuildColorData>
        {
            return (_guildSecondaryColors);
        }

        public function findMatchingPrimaryColorId(_arg_1:int):int
        {
            if (((((_arg_1 < 0) || (_badgeColors.length <= 0)) || (_badgeColors.length < _arg_1)) || (_guildPrimaryColors.length <= 0)))
            {
                return (0);
            };
            return (findClosestColor(_badgeColors[_arg_1], _guildPrimaryColors));
        }

        public function findMatchingSecondaryColorId(_arg_1:int):int
        {
            if (((((_arg_1 < 0) || (_badgeColors.length <= 0)) || (_badgeColors.length < _arg_1)) || (_guildSecondaryColors.length <= 0)))
            {
                return (0);
            };
            return (findClosestColor(_badgeColors[_arg_1], _guildSecondaryColors));
        }

        private function findClosestColor(_arg_1:GuildColorData, _arg_2:Vector.<GuildColorData>):int
        {
            var _local_8:int;
            var _local_5:IVector3d;
            var _local_6:Number;
            var _local_4:IVector3d = ColorConverter.rgb2CieLab(_arg_1.color);
            var _local_7:int;
            var _local_3:Number = 1.79769313486232E308;
            _local_8 = 0;
            while (_local_8 < _arg_2.length)
            {
                _local_5 = ColorConverter.rgb2CieLab(_arg_2[_local_8].color);
                _local_6 = ((Math.pow((_local_4.x - _local_5.x), 2) + Math.pow((_local_4.y - _local_5.y), 2)) + Math.pow((_local_4.z - _local_5.z), 2));
                if (_local_6 < _local_3)
                {
                    _local_3 = _local_6;
                    _local_7 = _local_8;
                };
                _local_8++;
            };
            return (_arg_2[_local_7].id);
        }


    }
}
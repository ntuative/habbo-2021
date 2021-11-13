package com.sulake.habbo.session
{
    public /*dynamic*/ interface IUserData 
    {

        function get roomObjectId():int;
        function get name():String;
        function get custom():String;
        function get achievementScore():int;
        function get type():int;
        function get figure():String;
        function get sex():String;
        function get groupID():String;
        function get groupStatus():int;
        function get groupName():String;
        function get webID():int;
        function get ownerId():int;
        function get ownerName():String;
        function get rarityLevel():int;
        function get hasSaddle():Boolean;
        function get isRiding():Boolean;
        function get canBreed():Boolean;
        function get canHarvest():Boolean;
        function get canRevive():Boolean;
        function get hasBreedingPermission():Boolean;
        function get petLevel():int;
        function get botSkills():Array;
        function get botSkillData():Array;
        function get isModerator():Boolean;
        function set figure(_arg_1:String):void;
        function set name(_arg_1:String):void;
        function set sex(_arg_1:String):void;
        function set custom(_arg_1:String):void;
        function set achievementScore(_arg_1:int):void;
        function set groupID(_arg_1:String):void;
        function set groupName(_arg_1:String):void;
        function set ownerId(_arg_1:int):void;
        function set ownerName(_arg_1:String):void;
        function set rarityLevel(_arg_1:int):void;
        function set hasSaddle(_arg_1:Boolean):void;
        function set isRiding(_arg_1:Boolean):void;
        function set canBreed(_arg_1:Boolean):void;
        function set canHarvest(_arg_1:Boolean):void;
        function set canRevive(_arg_1:Boolean):void;
        function set hasBreedingPermission(_arg_1:Boolean):void;
        function set petLevel(_arg_1:int):void;
        function set botSkills(_arg_1:Array):void;
        function set botSkillData(_arg_1:Array):void;
        function set isModerator(_arg_1:Boolean):void;

    }
}
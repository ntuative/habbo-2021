package com.sulake.habbo.session
{
    public /*dynamic*/ interface IUserDataManager 
    {

        function setUserData(_arg_1:IUserData):void;
        function getUserData(_arg_1:int):IUserData;
        function getUserDataByType(_arg_1:int, _arg_2:int):IUserData;
        function getUserDataByIndex(_arg_1:int):IUserData;
        function getUserDataByName(_arg_1:String):IUserData;
        function getUserBadges(_arg_1:int):Array;
        function removeUserDataByRoomIndex(_arg_1:int):void;
        function setUserBadges(_arg_1:int, _arg_2:Array):void;
        function updateFigure(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean):void;
        function updatePetLevel(_arg_1:int, _arg_2:int):void;
        function updatePetBreedingStatus(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean):void;
        function updateCustom(_arg_1:int, _arg_2:String):void;
        function updateAchievementScore(_arg_1:int, _arg_2:int):void;
        function updateNameByIndex(_arg_1:int, _arg_2:String):void;
        function getPetUserData(_arg_1:int):IUserData;
        function getRentableBotUserData(_arg_1:int):IUserData;
        function requestPetInfo(_arg_1:int):void;
        function getAllUserIds():Array;

    }
}
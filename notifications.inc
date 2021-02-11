[mcts-call-notification]

exten =>	DETON,1,Answer()
exten =>	DETON,n,Wait(1)
exten =>	DETON,n,Playback(notify/you-have-received-a)
exten =>	DETON,n,Playback(notify/detour-on)
exten =>	DETON,n,Playback(notify/notification)
exten =>	DETON,n,Wait(1)
exten =>	DETON,n,Playback(goodbye)
exten =>	DETON,n,hangup()

exten =>	DETOFF,1,Answer()
exten =>	DETOFF,n,Wait(1)
exten =>	DETOFF,n,Playback(notify/you-have-received-a)
exten =>	DETOFF,n,Playback(notify/detour-off)
exten =>	DETOFF,n,Playback(notify/notification)
exten =>	DETOFF,n,Wait(1)
exten =>	DETOFF,n,Playback(goodbye)
exten =>	DETOFF,n,hangup()



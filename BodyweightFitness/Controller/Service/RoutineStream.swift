import Foundation
import RxSwift

class RoutineStream {
    class var sharedInstance: RoutineStream {
        struct Static {
            static var instance: RoutineStream?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = RoutineStream()
        }
        
        return Static.instance!
    }
    
    var routine: Routine
    var routineSubject = PublishSubject<Routine>()
    
    init() {
        routine = PersistenceManager.getRoutine()
        routineSubject.onNext(routine)
    }
    
    func routineObservable() -> Observable<Routine> {
        return Observable.of(Observable.just(routine).publish().refCount(), routineSubject)
            .merge()
            .publish()
            .refCount()
    }
}
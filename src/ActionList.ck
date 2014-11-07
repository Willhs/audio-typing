// a list 
public class ActionList {
    10 => int cap;
    0 => int count;
    Action @ data[10];
    
    // adds an element to the list.
    public void add(Action action){
        if (count >= cap){
            ensureCap();
        }
        action @=> data[count];
        count++;
    }
    
    // removes the first element equal to key from the list. 
    // returns 1 if succesful, 0 if not.
    public int remove(Action action){
        for (0 => int i; i < count; i++){
            if (data[i].equals(action)){
                removeAt(i);
                return true;
            }
        }
        return false;
    }

    fun void removeAt(int from){
        if (from < 0 || from >= count){
            <<< "removeAt bad arg" >>>;
            return;
        }
        
        for (from => int i; i < count-1; i++){
            data[i+1] @=> data[i];
        }
        count--;
    }
    
    // is the list empty
    public int isEmpty(){
        return count <= 0;
    }
    
    // shouldn't have to use this because only <= 3 actions shuold be active at once.
    fun void ensureCap(){
        2 *=> cap;
        Action @ n[cap];
        for (0 => int i; i < count; i++){
            data[i] @=> n[i];
        }
        n @=> data;
    }
    
    
    public void clear(){
        // while there are still elements in the list, delete the first element
        data.clear();
        0 => count;
    }
    
    public Action get(int i){
        return data[i];
    }
    
    public int size(){
        return count;
    }
}
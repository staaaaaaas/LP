#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>
#include <locale.h>


typedef struct person {
    std::string name; //name
    int id; //index
    int sex; //sex of peron
} Person;


int Sex(const std::string &str) {
    if (str[6] == 'M')
        return 1;
    else {
        if (str[6] == 'F')
            return 2;
        else
        	return 0;
    }
}

int Element(std::vector <Person> &array, int element, int index = 0) {
    if (array[index].id != element)
        return Element(array, element, ++index);
    if (index == (array.size() / array.size() - 1))
        return  index;
    return index;
}

int Index(const std::string &str, int pos)     {
    char ch[50];
    int i;
    for(i = pos; str[i] != '@'; i++)
        ch[i - pos] = str[i];
    ch[i] = '\0';
    return atoi(ch);
}

void  Name(const std::string &str, std::string &name) {
    int i;
    for(i = 7; str[i] != '/'; i++) {
        if (str[i] != '"') {
            name.push_back(str[i]);
        }
    }
    for(i++ ; str[i] != '/'; i++) {
        if (str[i] != '"')
            name.push_back(str[i]);
    }
}


int main(){
    setlocale(LC_ALL,"rus");

    std::ifstream fin("rod.ged"); // input
    std::ofstream fout("parsed.pl");// output
    std::vector<Person> per;
    std::string str;
    Person human;

    if (fin.is_open()){
        while (getline(fin, str)) {
            if (str[0] == '0' && str[3] == 'I')  // до 27 пропуск
                break;
        }
        do {
            if (str[0] == '0') {
                if (str[3] == 'I')
                    human.id = Index(str, 4);
                else
                	break;
            } else if (str[0] == '1') {
                if (str.substr(2, 4) == "NAME")
                    Name(str, human.name);
                if (str.substr(2, 3) == "SEX") {
                    int ans = Sex(str);
                    if (ans == 1)
                    	human.sex = 1;
                    else if (ans == 2)
                    	human.sex = 2;
                    per.push_back(human);
                    human.name.clear();
                }
            }
        } while (getline(fin, str));

        int men = -1;
        int woman = -1;
        std::vector<int> vec;
        while(getline(fin, str)) {
            if (str[0] == '1') {
                std::string substr = str.substr(2, 4);
                if (substr == "HUSB") {
                    men = Index(str, 9);
                } else if (substr == "WIFE") {
                    woman = Index(str, 9);
                } else if (substr == "CHIL") {
                    vec.push_back(Index(str, 9));
                }
            } else if (str[0] == '0') {
                for (int i = 0; i < vec.size(); i++) {
                    if ((men != -1)&&(woman != -1)) {
                    	int index = Element(per, woman,0);
                        int index_ch = Element(per, vec[i],0);
                        fout << "mother(\"";
                        fout << per[index].name << "\", \"";
                        fout << per[index_ch].name << "\").\n";
                    }
                    if(men!=-1){
                        int index = Element(per, men,0);
                        int index_ch = Element(per, vec[i],0);
                        fout << "father(\"";
                        fout << per[index].name << "\", \"";
                        fout << per[index_ch].name << "\").\n";
                    }
                }
                men = -1;
                woman = -1;
                vec.clear();
            }
        }

        fin.close();
        fout.close();
        return 0;
    }
    else {
        std::cout << "Wrong input" << std::endl;
        return 0;
    }
}

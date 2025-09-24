// 两数之和
// 整数数组nums和目标值target
// 找出两个数字和为target的数组下标
// 只存在唯一解


#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "header/uthash.h"

// 暴力解法 [ time = O(n^2) | space = O(1) ]
int* twoSum_for(int* nums, int numsSize, int target, int* returnSize) {
    for (int i = 0; i< numsSize; ++i) {
        for (int j = i+1; j<numsSize; ++j) {
            if (nums[i] + nums[j] == target) {
                int * ret = malloc(sizeof(int) * 2);
                ret[0] = i, ret[1] = j;
                *returnSize = 2;
                return ret;
            }
        }
    }

    // 由于题目中规定好了只返还2个int长度的数组或者0个int长度的
    // 所以解题时需要返还数组的长度
    *returnSize = 0;
    return NULL;
}


// 哈希表解法 [time = O(n) | space = O(n)]
struct HashTable {
    int key;
    int val;
    UT_hash_handle hh;
};

struct HashTable* hashtable;

struct HashTable* find(int ikey) {
    struct HashTable* temp;
    HASH_FIND_INT(hashtable, &ikey, temp);
    return temp;
}

void insert(int ikey, int ival) {
    struct HashTable* it = find(ikey);
    if (it == NULL) {
        struct HashTable* temp = malloc(sizeof(struct HashTable));
        temp -> key = ikey, temp -> val = ival;
        HASH_ADD_INT(hashtable, key, temp);
    } else {
        it -> val = ival;
    }
}

int* twoSum_Hash(int* nums, int numsSize, int target, int* returnSize) {
    hashtable = NULL;
    for (int i=0; i<numsSize; ++i) {
        struct HashTable* it = find(target - nums[i]);
        if (it != NULL) {
            int * ret = malloc(sizeof(int)*2) ;
            ret[0] = it->val, ret[1] = i;
            *returnSize = 2;
            return ret;
        }
        insert(nums[i], i);
    }
    *returnSize = 0;
    return NULL;

}

// main 开始的地方
int main() {
    int nums[] = {2,7,11,15};
    int numsSize = 4;
    int target = 18;
    int returnSize = 2;
    int answer_correct[] = {1,2};

    int * af = twoSum_for(nums, numsSize, target, &returnSize); // 暴力解法
    int * ah = twoSum_Hash(nums, numsSize, target, &returnSize); // 哈希表解法

    bool c1 = memcmp(af, answer_correct, sizeof(answer_correct)) == 0;
    bool c2 = memcmp(ah, answer_correct, sizeof(answer_correct)) == 0;

    if (c1 && c2) { printf("Q_0001解题成功"); }

    return 0;
}
